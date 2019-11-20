#!/bin/bash
elm make src/Main.elm --optimize --output=public/resume.js
elm reactor
