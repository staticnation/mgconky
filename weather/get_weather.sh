#!/bin/bash
###################################################################################################################################
# This script is from the "Harmattan Conky Theme" project: https://github.com/zagortenay333/Harmattan
# It has been modified by Matt Grotke (mgrotke@gmail.com) for the "mgconky Conky Theme" project: https://github.com/mgrotke/mgconky
# Below is Harmattan's original license for this file.
# ---------------------------------------------------------------------------------------------------------------------------------
# This project is available under 2 licenses -- choose whichever you prefer.
# ---
# ALTERNATIVE A - MIT License Copyright (c) 2019 zagortenay333
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions: The above copyright
# notice and this permission notice shall be included in all copies or
# substantial portions of the Software.  THE SOFTWARE IS PROVIDED "AS IS",
# WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
# TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
# FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
# THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# ---
# ALTERNATIVE B - Public Domain (www.unlicense.org)
# This is free and unencumbered software released into the public domain.
# Anyone is free to copy, modify, publish, use, compile, sell, or distribute
# this software, either in source code form or as a compiled binary, for any
# purpose, commercial or non-commercial, and by any means.  In jurisdictions
# that recognize copyright laws, the author or authors of this software
# dedicate any and all copyright interest in the software to the public domain.
# We make this dedication for the benefit of the public at large and to the
# detriment of our heirs and successors. We intend this dedication to be an
# overt act of relinquishment in perpetuity of all present and future rights to
# this software under copyright law.  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT
# WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
# OR OTHER DEALINGS IN THE SOFTWARE.
# ---------------------------------------------------------------------------------------------------------------------------------
# INTENDED USAGE BY A CONKY CONFIGURATION FILE:
#       template6 "<your API key here>"                   # OpenWeatherMap API key (https://home.openweathermap.org/api_keys)
#       template7 "<your city ID here>"                   # OpenWeatherMap City ID (the number in the URL of your city, for example:  https://openweathermap.org/city/5128581)
#       template8 "imperial"                              # Temp unit ("default" for Kelvin, "metric" for Celcius, "imperial" for Fahrenheit)
#       template9 ""                                      # Locale (e.g. "es_ES.UTF-8") # Leave empty for default
#       TEXT
#       ${execi 300 ~/.conky/mgconky/weather/get_weather.sh ${template6} ${template7} ${template8} ${template9}}
# RESULT:
#       Two JSON files will now be downloaded and saved in the ~/.cache/mgconky/ folder.
###################################################################################################################################
set -eu

# It seems that in conky the execi command will start before curl has completely
# written the file. For some reason adding a sleep before calling curl fixes it.
sleep 2

forecast=~/".cache/mgconky/forecast.json"
weather=~/".cache/mgconky/weather.json"

mkdir -p ~/".cache/mgconky"

api_prefix="api.openweathermap.org/data/2.5/"

appid="APPID=$1"
id="&id=$2"
units="&units=$3"
lang="" ; [[ -v 4 ]] && lang="${4%%_*}" lang="&lang=$lang"

curl -s "${api_prefix}forecast?${appid}${id}${units}${lang}" -o "$forecast"
curl -s "${api_prefix}weather?${appid}${id}${units}${lang}" -o "$weather"
