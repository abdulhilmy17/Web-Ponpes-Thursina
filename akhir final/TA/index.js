const http = require('http');
const fs = require('fs');
const url = require('url');
const express = require('express');
const hbs = require('hbs');
const path = require('path');
const bodyParser = require('body-parser');
const mysql = require('mysql');
var session = require('express-session');
//======================================
var formidable = require('formidable');
var formidable = require('formidable');
var mv = require('mv');
var multer= require ('multer');
const { FILE } = require('dns');
//==================================
const app = express();
//konfigurasi koneksi
const conn = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'hidroponik'
  });
//connect ke database
conn.connect((err) =>{
    if(err) throw err;
    console.log('koneksi tersambung');
  });

//set views file
app.set('views',path.join(__dirname,'views'));
//set view engine
app.set('view engine', 'hbs');
app.use(session({
	secret: 'secret',
	resave: true,
	saveUninitialized: true
}));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
//set folder public dan views  sebagai static folder untuk static file
app.use('/assets',express.static(__dirname + '/public'));
app.use('/views',express.static(__dirname + '/views'));
app.use('/uploads',express.static(__dirname + '/uploads'));
//potongan/partials layout web
hbs.registerPartials(__dirname + '/views/partials');
hbs.registerPartial('header', 
    fs.readFileSync(__dirname + '/views/partials/header.hbs', 'utf8'));
hbs.registerPartial('main', 
    fs.readFileSync(__dirname + '/views/partials/main.hbs', 'utf8'));              
hbs.registerPartial('footer', 
    fs.readFileSync(__dirname + '/views/partials/footer.hbs', 'utf8'));
hbs.registerPartial('form_upload', 
    fs.readFileSync(__dirname + '/views/nodejs-upload/form_upload.hbs', 'utf8'));
    hbs.registerPartial('menuadmin', 
    fs.readFileSync(__dirname + '/views/partials/menuadmin.hbs', 'utf8'));


//====================Routing============================
//SB_Login================= 
app.get('/',(req, res) => {
    res.render('home_sb')
});
app.get('/about_sb',(req, res) => {
  res.render('about_sb')
});
app.get('/home_sb',(req, res) => {
res.render('home_sb')
});
app.get('/from_pelanggan',(req, res) => {       //form dftar akun
  res.render('from_pelanggan')
});
app.get('/belanja_sb',(req, res) => {
  let sql = "SELECT * FROM sayuran ORDER BY id DESC";
  let query = conn.query(sql, (err, results) => {
    if(err) throw err;
    res.render('belanja_sb',{
      results: results
    });
  });
});
//register
app.post('/simpan_pelanggan',(req, res) => {
  let data = {nama_pelanggan: req.body.nama_pelanggan, hp: req.body.hp,
              alamat: req.body.alamat, email: req.body.email, password: req.body.password};
  let sql = "INSERT INTO pelanggan SET ?";
  let query = conn.query(sql, data,(err, results) => {
    if(err) throw err;
    res.redirect('/login_pelanggan');
  });
});

app.get('/login',(req, res) => {
  res.render('login')
});
app.get('/login_pelanggan',(req, res) => {
  res.render('login_pelanggan')
});


//ST_Login_User==============
app.get('/home',(req, res) => {
  res.render('home')
});
app.get('/about',(req, res) => {
    res.render('about')
});
app.get('/contact',(req, res) => {
  res.render('contact')
});
app.get('/from_sayuran',(req, res) => {
  res.render('from_sayuran')
});
app.get('/belanja',(req, res) => {
  let sql = "SELECT * FROM sayuran ORDER BY id DESC";
  let query = conn.query(sql, (err, results) => {
    if(err) throw err;
    res.render('belanja',{
      results: results
    });
  });
});


//ST_Login_Admin==============
app.get('/menuadmin',(req, res) => {
  res.render('menuadmin')
});
app.get('/sayuran',(req, res) => {
  let sql = "SELECT * FROM sayuran ORDER BY id DESC";
  let query = conn.query(sql, (err, results) => {
    if(err) throw err;
    res.render('data_sayuran',{
      results: results
    });
  });
});


//Login_Form===============================================
//User_Login========
app.post('/auth2', function(request, response) {
	var email = request.body.email;
	var password = request.body.password;
	if (email && password) {
		conn.query('SELECT * FROM pelanggan WHERE email = ? AND password = ?', [email, password], function(error, results, fields) {
			if (results.length > 0) {
				request.session.loggedin = true;
				request.session.email = email;
				response.redirect('/belanja');
			} else {
                response.send('<script> alert("password atau username yang anda masukkan salah!!"); history.go(-1)</script>');
			}			
			response.end();
		});
	} else {
		response.send('Please enter Username and Password!');
		response.end();
	}
});

//Admin_Login===============
app.post('/auth', function(request, response) {
	var username = request.body.username;
	var password = request.body.password;
	if (username && password) {
		conn.query('SELECT * FROM user WHERE username = ? AND password = sha1(?)', [username, password], function(error, results, fields) {
			if (results.length > 0) {
				request.session.loggedin = true;
				request.session.username = username;
				response.redirect('/sayuran');
			} else {
                response.send('<script> alert("password atau username yang anda masukkan salah!!"); history.go(-1)</script>');
			}			
			response.end();
		});
	} else {
		response.send('Please enter Username and Password!');
		response.end();
	}
});
//=========================================================End_Routing===================================


//CRUD_Sayuran===========================================================================================
app.post('/simpan_sayuran',(req, res) => {
    let data = {nama: req.body.nama, harga: req.body.harga,
                keterangan: req.body.keterangan, status: req.body.status, gambar: req.body.gambar};
    let sql = "INSERT INTO sayuran SET ?";
    let query = conn.query(sql, data,(err, results) => {
      if(err) throw err;
      res.redirect('/sayuran');
    });
  });

  app.get('/hapus/(:id)',(req, res) => {
    let id = req.params.id;//tangkap request
    let sql = "DELETE FROM sayuran where id="+ id +"";
    let query = conn.query(sql, (err, results) => {
      if(err) throw err;
        res.redirect('/sayuran');
    });
  });
  //retrun untuk edik/di arahkan ke halama edit
  app.get('/edit/(:id)',(req, res, next) => {
    let id = req.params.id;
    let sql = 'select * FROM sayuran where id='+id;
    let query = conn.query(sql, (err, results,) => {
      if(err) throw err;
      //arahkan ke arah from edit di sertai dng data yang mau di edit
        res.render('form_edit_sayuran',{results:results});
    });
  });
  //root untuk proses ubah data dari from edit
  app.post('/ubah',(req, res) => {
    let nama = req.body.nama;let harga = req.body.harga;let status = req.body.status;let gambar = req.body.gambar;let id = req.body.id;let keterangan = req.body.keterangan;
    //jalani query update
    let sql = "update sayuran set nama ='"+ nama+"',harga ='"+ harga+"',status ='"+ status+"',gambar ='"+ gambar+"',keterangan ='"+ keterangan+"' where id="+id+"";
    let query = conn.query(sql, (err, results) => {
      if(err) throw err;
        res.redirect('/sayuran');
    });
  });
  //CRUD_END==============================================================================================




//======================Port============================
app.listen(8000, () => {
    console.log('Server is running at port 8000');
});


