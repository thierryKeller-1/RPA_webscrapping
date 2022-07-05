*** Settings ***
Library  SeleniumLibrary


*** Variable ***


*** Keywords ***
Open The Browser
    Log To Console                      Opening The Browser
    Open Browser                        http://regionalip.aripo.org/wopublish-search/public/home    FF
    Maximize Browser Window

Close The Browser
    Log To Console                      Closing The browser
    Close Browser
    