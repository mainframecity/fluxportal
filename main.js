'use strict'
const electron = require('electron')

const app = electron.app
const BrowserWindow = electron.BrowserWindow

let mainWindow

app.on('ready', createWindow)

function createWindow () {
  mainWindow = new BrowserWindow({
    width: 1024, 
    height: 768,
    title: "fluxportal",
    frame: false,
    resizable: false
  })

  mainWindow.loadURL(`file://${ __dirname }/src/static/index.html`)

  
  mainWindow.webContents.openDevTools({'mode': 'detach'})
  mainWindow.focus()

  mainWindow.on('closed', function () {
    mainWindow = null
  })
}

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') { app.quit() }
})

app.on('activate', () => {
  if (mainWindow === null) { createWindow() }
})
