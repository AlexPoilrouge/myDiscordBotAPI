const { response } = require('express')
const fetch= require('node-fetch')

let hereLog= (...args) => {console.log("[api.js]", ...args);};

const config= require("../config/config.json")

const DISCORD_API_BASE_URL='https://discordapp.com/api'

const DISCORD_REQ_USER='users/@me'

const DISCORD_IMG_BASE_URL='https://cdn.discordapp.com'

function fetchAvatarUrl(){
    let req_url=`${DISCORD_API_BASE_URL}/${DISCORD_REQ_USER}`

    hereLog(`--> ${req_url} + ${config.discord.BOT_TOKEN_ID}`)

    return fetch(
            req_url,
            {    headers: { 
                    'Content-Type': 'application/json',
                    'Authorization': `Bot ${config.discord.BOT_TOKEN_ID}`
            }   }
        )
        .then(response => response.json())
        .then(data => {
            if(!Boolean(data.id && data.avatar)){
                throw "couldn't fetch data from api…"
            }

            return `${DISCORD_IMG_BASE_URL}/avatars/${data.id}/${data.avatar}.png`
        })
}

module.exports= {
    fetchAvatarUrl
}
