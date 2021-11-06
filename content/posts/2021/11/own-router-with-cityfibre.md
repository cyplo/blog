---
title: Using own OpenWRT router with Vodafone/Cityfibre
date: 2021-11-04
tags: [hardware, freedom]
---

For something very different this time, a quick recipe for a very specific situation.

One of the very few fiber-to-the-home solutions in the UK is through Cityfibre, sold as Vodafone "Gigafast" packages where I live. As with other ISPs they give you their own internet router. If you would like to use your own, here's how.

`TLDR; Obtain PPPoE credentials specific to your account from Vodafone, then use them to configure your router, you need to tag all your packets with VLAN 911.`


1. Obtain PPPoE credentials from Vodafone. You can do so by using the chat feature on their website. Here's an example chat transcript pasted here for your enjoyment and pleasure

```
 Tobi : I’m TOBi - Vodafone’s chatbot Ask me anything, I’m here to help.
You : hi, I would like to swap the provider router for the own router, could you share the PPPoE credentials I would need to use ? thank you
Tobi : Please try asking your question again using fewer words, making sure you only ask one question at a time. You’ll be able to ask other questions later if you need to.
You : ppoe credentials
Tobi : TOBi is thinking...
TOBi : Sorry, I didn't understand the question. Can you please try rephrasing?
You : own router ppoe credentials
TOBi : Sorry, I didn't understand the question. Can you please try rephrasing?
You : can I speak to a human please ?
TOBi : Could you tell me your full name please?
You : xxxxxxxxxxxxxxx
TOBi : Could you please tell me your phone number?
You : xxxxxxxxxxx
TOBi : Please tell me what type of account you have with us:
TOBi :
    Pay Monthly
    Pay As You Go
    Small Business
    Broadband
You : Broadband
Pragya : Hi , you're now connected to Broadband chat support. Please give me 1-2 minutes as I quickly go through your conversation so that you don't have to repeat yourself.
You : Hi, perfect, thank you :)
Pragya : Cyryl , Thank you for waiting
Pragya : As per the pre chat , I understand that you wish to have PPOE details , right , Cyryl ?
You : that's correct, I'm trying to establish connection using own hardware
Pragya : Cyryl , Thank you lets do a quick security check ,
Please share your broadband account number or home phone number once so I can locate your account and proceed further.
You : account number xxxxxxxxxx
Pragya : Thank you very much
Pragya : I have your account ready. Let's complete a quick security check so that I can try to resolve this for you.
Pragya : Confirm the 2nd and 3rd digit of the security PIn ?
You : xxxxxxx
Pragya : Thank you let me verify it
Pragya : Brilliant that matches the record
Pragya : Would you mind being online for few minutes, while I am checking the details ?
You : no problem, thank you
Pragya : Thank you , Moving away from the chat window or not responding for 8 mins may result in losing the chat. If it does, here's a link to get back to us faster than usual: https://www.vodafone.co.uk/bbservcd
Pragya : Thank you for waiting
Pragya : Here is the username - dsl123456789@broadband.vodafone.co.uk
Pragya : Password is - XXXXXXXX

```

2. armed with that knowledge you can configure your router, I'm gonna give an example of configuring an OpenWRT router via their GUI interface LuCI 
  * backup your settings
  * -> Network->Interfaces
  * note down the physical interface of current WAN interface - (`WAN`->Edit->Physical Settings), e.g. `eth2`
  * remove existing `WAN` interface, press `save and apply`
  * add a new PPPoE interface:
    * Name: `WAN`
    * Protocol: `PPPoE`
    * interface - type in the `custom` field - name of your physical interface followed by a dot and `911` indicating the VLAN number to tag packets with - e.g. `eth2.911`
    * -> create interface
    * PAP/CHAP username: [username from Vodafone]
    * PAP/CHAP password: [password form Vodafone]
    * -> Firewall settings
    * Create / Assign firewall-zone: `WAN`
    * -> save
    * -> save and apply
    * wait around a minute for the router to connect

