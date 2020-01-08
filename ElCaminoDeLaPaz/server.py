import os
from flask_bcrypt import Bcrypt
from flask import Flask, render_template, request, redirect, session, flash, url_for
import re
from mysqlconnection import connectToMySQL
app = Flask(__name__)
app.secret_key = "keep it secret"
bcrypt = Bcrypt(app)

@app.route('/')
def index_home():
    return render_template("home.html")

@app.route('/loginpage')
def index_loginpage():
    return render_template("log_reg.html")

EMAIL_REGEX = re.compile(r'^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]+$') 
@app.route("/register", methods=["POST"])
def register():
    mysql = connectToMySQL('project')
    users = mysql.query_db('SELECT * FROM users;')
    is_valid = True
    if len(request.form['firstname']) < 1:
        is_valid = False
        flash("Please input your first name")
    if len(request.form['lastname']) < 1:
        is_valid = False
        flash("Please input your last name")
    if not EMAIL_REGEX.match(request.form['registration_email']):
        is_valid = False
        flash("Invalid email address!")
    if len(request.form['registration_email']) > 45:
        is_valid = False
        flash('Invalid email address!')
    for info in users:
        if request.form['registration_email'] == info['email']:
            is_valid = False
            flash('Email already registered')
    if len(request.form['registration_password']) <= 7:
        is_valid = False
        flash('Passwords must have a minimum of 8 characters')
    if request.form['confirmation_password'] != request.form['registration_password']:
        is_valid = False
        flash('Confirmation password does not match')
    if not is_valid:
        return redirect('/')
    else:
        pw_hash = bcrypt.generate_password_hash(request.form['registration_password'])  
        mysql = connectToMySQL("project")
        query = "INSERT INTO users (first_name, last_name, email, password) VALUES (%(fn)s, %(ln)s, %(em)s, %(pw)s);"
        data = {
            "fn" : request.form["firstname"],
            "ln" : request.form['lastname'],
            "em" : request.form['registration_email'],
            "pw" : pw_hash
            }
        mysql.query_db(query, data)
        flash("User successfully registered!")
        session['first_name']=request.form['firstname']
        mysql = connectToMySQL('project')
        query="SELECT user_id FROM users WHERE email = %(em)s;"
        data = {
            'em' : request.form['registration_email']
        }
        finduid=mysql.query_db(query,data)
        session['userid']=finduid[0]['user_id']
        print(session['userid'])
    return redirect("/wall")

@app.route('/login', methods=['POST'])
def login():
    if len(request.form["login_email"]) > 3:
        mysql = connectToMySQL("project")
        query = "SELECT * FROM users WHERE email = %(email)s;"
        data = {"email" : request.form["login_email"]}
        result = mysql.query_db(query, data)
    if len(request.form["login_password"]) > 0:
        for info in result:
            if bcrypt.check_password_hash(info['password'], request.form['login_password']):
                session['userid'] = info['user_id']
                session['first_name']=info['first_name']
                return redirect('/wall')
    flash("You could not be logged in")
    return redirect("/")

@app.route('/mytracks')
def my_tracks():
    if 'userid' not in session:
        flash("Please log in or register to view My Tracks")
        return redirect('/loginpage')
    return render_template('mytracks.html')

@app.route('/trails')
def trails():
    return render_template('trail.html')

@app.route('/events')
def events():
    return render_template('events.html')

@app.route('/rest_bar')
def rest_bars():
    return render_template('rest_bar.html')

@app.route('/uploading')
def uploads():
    return render_template('uploading.html')

@app.route("/handleUpload", methods=['POST'])
def handleFileUpload():
    if 'photo' in request.files:
        photo = request.files['photo']
        if photo.filename != '':            
            photo.save(os.path.join('C:/Users/Public/Pictures', photo.filename))
    return redirect(url_for('fileFrontPage'))

@app.route("/handleUpload/image")
def handleimg():
    return render_template('chill.html')

@app.route("/handleUpload/video")
def handlevid():
    return render_template('Posted.html')

@app.route('/myreview', methods=['post'])
def handlereview():
    mysql = connectToMySQL('project')
    query = "INSERT into posts (description, location, uploaded_by_id) VALUES (%(review)s,%(loc)s, %(uid)s);"
    session['userid'] = str(session['userid'])
    data = {
        'review' : request.form['description'],
        'loc' : request.form['location'],
        'uid' : session['userid']
    }
    posts=mysql.query_db(query,data)
    print(posts)
    return redirect ('mytracks')




@app.route('/wall')
def successful_login():
    mysql = connectToMySQL('project')
    query = "SELECT posts.post_id, posts.uploaded_by_id, posts.location FROM posts;"
    if 'first_name' not in session:
        return redirect('/')
    all_posts = mysql.query_db(query)
    print(all_posts)
    mysql = connectToMySQL('project')
    query = "SELECT * from favorites where users_user_id = " + str(session['userid']) + ";"
    favorties=mysql.query_db(query)
    print(favorties)
    return render_template("home.html", all_posts=all_posts, favorties=favorties)

@app.route('/newpost')
def newpost_link():
    return render_template('newpost.html')

@app.route('/add_post', methods=['POST'])
def add_post():
    mysql = connectToMySQL('project')
    is_valid = True
    if len(request.form['description']) < 1:
        is_valid = False
        flash('A description must be provided')
    if len(request.form['location']) < 1:
        is_valid = False
        flash("A location must be provided")
    if not is_valid:
        return redirect('/newpost')
    else:
        mysql = connectToMySQL("project")
        query = "INSERT INTO posts (description, location, uploaded_by_id, created_at) VALUES (%(t)s, %(d)s, %(l)s, %(ubid)s, NOW());"
        data = {
            'd' : request.form['description'],
            'l' : request.form['location'],
            'ubid' : session['userid']
        }
        mysql.query_db(query, data)
    return redirect("/wall")

@app.route('/add_to_favorites/<int:id>')
def add_to_favorites(id):
    id=str(id)
    userid=str(session['userid'])
    mysql = connectToMySQL("project")
    query = "INSERT INTO favorites (`users_user_id`, `posts_post_id`) VALUES (%(uid)s, %(bid)s);"
    data = {
        'bid' : id,
        'uid' : userid
    }
    mysql.query_db(query,data)
    return redirect('/wall')

@app.route('/view/<int:id>')
def viewpost(id):
    jid=str(id)
    mysql = connectToMySQL("project")
    query = "SELECT posts.post_id, posts.description, posts.location, posts.created_at, posts.uploaded_by_id FROM posts WHERE post_id = %(posts_id)s;"
    data = {
        "posts_id" : jid
    }
    postinfo=mysql.query_db(query,data)
    uploaded_by_id=postinfo[0]['uploaded_by_id']
    up=str(uploaded_by_id)
    mysql = connectToMySQL('project')
    query = "SELECT first_name from users where user_id = %(UID)s;"
    data = {
        'UID' : up
    }
    name=mysql.query_db(query,data)
    print(postinfo)
    print(name)
    print(session)
    return render_template("view.html", postinfo=postinfo, name=name)

@app.route('/edit/<int:id>')
def reroute_edit(id):
    id=int(id)
    mysql = connectToMySQL('project')
    query = "SELECT post_id, description, location FROM posts WHERE post_id = %(jid)s;"
    data = {
        'jid' : id
    }
    info=mysql.query_db(query,data)
    return render_template('edit.html', allinfo=info)

@app.route('/official/edit/<int:id>', methods=['POST'])
def edit(id):
    id = str(id)
    mysql = connectToMySQL('project')
    is_valid = True
    if len(request.form['description']) < 1:
        is_valid = False
        flash('A description must be provided')
    if len(request.form['location']) < 1:
        is_valid = False
        flash("A location must be provided")
    if not is_valid:
        return redirect('/edit/' + id)
    else:
        mysql = connectToMySQL('project')
        query = "UPDATE posts SET description = %(desc)s, location = %(loc)s WHERE post_id = %(bid)s;"
        data = {
            'desc' : request.form['description'],
            'loc' : request.form['location'],
            'bid' : id
        }
        mysql.query_db(query,data)
    return redirect('/wall')


@app.route('/delete/<int:id>')
def delete_post(id):
    id = str(id)
    mysql = connectToMySQL('project')
    query = "DELETE FROM posts WHERE post_id = %(id)s;"
    data = {"id" : id}
    mysql.query_db(query, data)
    return redirect("/wall")

@app.route('/remove/<int:id>')
def giveup(id):
    jid = str(id)
    mysql = connectToMySQL('project')
    query = "DELETE FROM favorites WHERE posts_post_id = %(jid)s and users_user_id = %(uid)s;"
    uid = str(session['userid'])
    data = {
        'jid' : jid,
        'uid' : uid
    }
    mysql.query_db(query,data)
    return redirect('/wall')

@app.route('/logout')
def logout():
    session.clear()
    return redirect('/')

if __name__ == "__main__":
    app.run(debug=True)