from flask import Flask,render_template,flash,redirect,url_for,session,logging,request
from flask_mysqldb import MySQL
from wtforms import Form,StringField,TextAreaField,PasswordField,validators,EmailField
from passlib.hash import sha256_crypt
import email_validator
from functools import wraps


#User Login Decorator
def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "logged_in" in session:
            return f(*args, **kwargs)
        else:
            flash("For open this page, you must be logged in!","danger")
            return redirect(url_for("login"))
    return decorated_function

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

#User Login Form    
class LoginForm(Form):
    username = StringField("Username")
    password = PasswordField("Password")    


app = Flask(__name__)


app.secret_key = "evorzblog"

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


@app.route("/dashboard")
@login_required
def dashboard():
    return render_template("dashboard.html")




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
        
        flash("You have registered successfully.","success")
    
        return redirect(url_for("index"))
    
    else:
        return render_template("login.html",form = form)
    
@app.route("/login", methods = ["GET","POST"])
def login():
    form = LoginForm(request.form)
    if request.method == "POST":
        username = form.username.data
        password_entered = form.password.data
    
        cursor = mysql.connection.cursor()
        
        query = "Select * from users where username = %s"
        
        result = cursor.execute(query,(username,))
        
        if result > 0:
            data = cursor.fetchone()
            real_password = data["password"]
            
            if sha256_crypt.verify(password_entered,real_password):
                flash("You have login successfully.","success")
                
                session["logged_in"] = True
                session["username"] = username
                
                return redirect(url_for("index"))
            else:
                flash("You entered incorrect password!","danger")
                return redirect(url_for("login"))
            
        else:
            flash("There is no user with this username!","danger")
            return redirect(url_for("login"))
    
    return render_template("login.html",form = form)


@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for("index"))

#Add article
@app.route('/addarticle',methods = ["GET", "POST"])
def addarticle():
    form = ArticleForm(request.form)
    if request.method == "POST" and form.validate():
        title = form.title.data
        content = form.content.data
        
        cursor = mysql.connection.cursor()
        
        query = "Insert into articles(title,author,content) VALUES(%s,%s,%s)"
        
        cursor.execute(query,(title,session["username"],content))    
        
        mysql.connection.commit()    
        
        cursor.close()
        
        flash("Article successfully added.","success")
        
        return redirect(url_for("dashboard"))
        
    return render_template("addarticle.html",form = form)

#Article Form
class ArticleForm(Form):
    title = StringField("Article Title",validators = [validators.length(min = 5, max = 100)])
    content = TextAreaField("Article Content",validators = [validators.length(min = 10)])
    




if __name__  == '__main__':
    app.run(debug=True)

    
    
    

