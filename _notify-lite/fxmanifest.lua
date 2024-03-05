-- Main
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

-- Signature 
author 'rsb.systems - HoodRusher#9080'
description 'Advanced Notification System made for NLRP'
version 'beta-1.0'

-- Files 
server_scripts { 'server/*.lua' }
shared_scripts { 'shared/*.lua' }
client_scripts { 'client/*.lua' }

escrow_ignore { 'shared/*.lua' }

ui_page( 'html/index.html' )
files({ 'html/*.*' })