
    const express= require('express');
    
    var mysql=require('mysql2');
    
    var connection=mysql.createConnection
    ({
        host: '127.0.0.1',
        user: 'root',
        password:'',
        database:'hostel-hunt',       // 3306 is default port no. of mysql 
     // your db name
    });
    
    
    connection.connect(function(err){
        if(err) throw err;
        console.log('db connected');
    });
    
    
    module.exports = connection;