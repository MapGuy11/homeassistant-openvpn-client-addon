# Home Assistant OpenVPN Client Add-On

## About: 
This is an Add-On for [Home Assistant](https://www.home-assistant.io) which enables you to tunnel some or all the communication of your Home Assistant server with the world through an OpenVPN connection.

Depending on how your OpenVPN connection is set up will determine the amount of traffic that flows through the VPN.

## Installation
1. Go back to the **Add-on store**, click **⋮ → Repositories**, fill in</br>  `https://github.com/MapGuy11/homeassistant-openvpn-client-addon` and click **Add → Close** or click the **Add repository** button below, click **Add → Close** (You may have to enter the **internal IP address** of your Home Assistant instance first).  
[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2FMapGuy11%2Fhomeassistant-openvpn-client-addon)
2. Use a tool to copy your `.ovpn` file to the `/config` directory
3. Go to the `Configuration` tab on the addon and input the file name with the extension there for the file you want to run.
4. Start the addon in Home Assistant and you are good to go!

## License:

Copyright (c) 2022-2023 Connor Hackenberg

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
