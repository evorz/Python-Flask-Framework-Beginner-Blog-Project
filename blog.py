from flask import Flask,render_template,flash,redirect,url_for,session,logging,request
from flask_mysqldb import MySQL
from wtforms import Form,StringField,TextAreaField,PasswordField,validators,EmailField
from passlib.hash import sha256_crypt
import email_validator

#User Registration Form
class RegisterForm(Form):
    name = StringField("Name Surname", validators = [validators.Length(min = 4, max = 25)])
    username = StringField("Username", validators= [validators.Length(min = 5, max = 35)])
    email = StringField("Email", validators= [validators.Email(message = "Please enter a valid email address!")])
    password = PasswordField("Password", validators= [
        validators.DataRequired(message = "Please enter a password!"),
        validators.EqualTo(fieldname = "confirm",message = "Password does not match!")
    ])
    confirm = PasswordField("Confirm Password")
    


app = Flask(__name__)

app.config["MYSQL_HOST"] = "localhost" #uzak sunucu olsaydı ip olacaktı
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = ""
app.config["MYSQL_DB"] = "evorzblog"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"

mysql = MySQL(app)

@app.route("/")
def index():
    articles = [
        {"id" : 1, "title" : "Trying1", "content" : "Trying1 content"},
        {"id" : 2, "title" : "Trying2", "content" : "Trying2 content"},
        {"id" : 3, "title" : "Trying3", "content" : "Trying3 content"}   
    ]
    return render_template("index.html",articles = articles)


@app.route("/about")
def about():
    return render_template("about.html")


@app.route("/register",methods = ["GET", "POST"])
def register():
    form = RegisterForm(request.form)
    
    if request.method == "POST" and form.validate():
        name = form.name.data
        username = form.username.data
        email = form.email.data
        password = sha256_crypt.encrypt(form.password.data)
        
        cursor = mysql.connection.cursor()
        
        query = "Insert Into users(name,email,username,password) VALUES(%s,%s,%s,%s)"
        
        cursor.execute(query, (name,email,username,password))
        
        mysql.connection.commit()

        cursor.close()
    
        return redirect(url_for("index"))
    else:
        return render_template("register.html",form = form)



@app.route("/article/<string:id>")
def detail(id):
    return "Article " + id








if __name__  == '__main__':
    app.run(debug=True)

    
    
    

