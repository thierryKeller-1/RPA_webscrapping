*** Settings ***
Library             SeleniumLibrary
Library             Tables
Resource            ../Resources/CommonTask.robot



*** Variables ***
# ${table}     Create List


*** Test Cases ***
Start Program
    Open The Browser
    Open Link
    Check Table


*** Keywords ***
Open The Browser
    Log To Console                      Opening The Browser
    Open Browser                        http://regionalip.aripo.org/wopublish-search/public/home  Chrome
    Maximize Browser Window

    
Open Link  
    Wait Until Element Is Visible                         xpath://*[@id="idf"]/div/div[2]/a 
    Click Link                                            xpath://*[@id="idf"]/div/div[2]/a
    Sleep                                                 10s


Check Table
    Sleep                                                 10s
    Wait Until Element Is Visible                         xpath://*[@id="dataTable"]/tbody
    ${table}    Get Web Elements                          xpath://*[@id="dataTable"]/tbody/tr
    FOR    ${element}    IN    ${table}
        Log To Console    ${element}
    END

