const express= require('express');
const bodyParser= require('body-parser');
const path= require('path')



let hereLog= (...args) => {console.log("[api.js]", ...args);};

const config= require("./config/config.json");

const { fetchAvatarUrl }= require('./src/discordFetch');

const app= express();

// support parsing of application/json type post data
app.use(bodyParser.json());

//support parsing of application/x-www-form-urlencoded post data
app.use(bodyParser.urlencoded({ extended: true }));

app.listen(config.PORT, ()=>console.log(`listening on ${config.PORT}`));

app.get('/avatar.png', function(req, res){
    fetchAvatarUrl()
        .then(url => res.redirect(url))
        .catch(err => {
            hereLog(`(fetchAvatar) - error while fetching avatar url - ${err}`)
            res.sendFile( path.resolve(__dirname,'img/fallback.png') )
        })
        .catch(err => {
            hereLog(`(fetchAvatar) - error fetching avatar img - ${err}`)
        })
});

app.get('/access', function(req, res){
    res.redirect(
        `https://discord.gg/${config.discord.INVITE_ID}`
    )
        .then(url => res.redirect(url))
        .catch(err => {
            hereLog(`(fetchInvite) - error ${err}`)
        })
});
