*** Settings ***
Library                              SeleniumLibrary
Library                              Collections
Library                              ../Libraries/Outputexcel.py
Resource                             ../Resources/CommonTask.robot

*** Variables ***
${link_gambia}                       http://regionalip.aripo.org/wopublish-search/public/trademarks?query=OFCO:GM
${link_rwanda}                       http://regionalip.aripo.org/wopublish-search/public/trademarks?query=OFCO:RW
${next_link}                         //*[@id="id37"]
${target_page_name}                  Rwanda

@{LINKS}                             @{EMPTY}
@{STATUS}                            @{EMPTY}
@{MARKS}                             @{EMPTY}
@{ORIGINAL_FILING_NUMBERS}           @{EMPTY}
@{PUBLICATION_NUMBERS}               @{EMPTY}
@{ORIGINAL_REGISTRATION_NUMBERS}     @{EMPTY}
@{NICE_CLASSES}                      @{EMPTY}
@{APPLICANTS}                        @{EMPTY}
@{FILING_DATES}                      @{EMPTY}
@{PUBLICATION_DATES}                 @{EMPTY}
@{REGISTRATION_DATES}                @{EMPTY}
@{VIENNA_CLASSES}                    @{EMPTY}
@{DESIGNATED_STATES}                 @{EMPTY}
@{APPLICANTS}                        @{EMPTY}


&{DATAS}                             &{EMPTY}                           

*** Test Cases ***
Start Program
    Open The Browser
    Open Link
    Log To Console                                                    start scrapping ${target_page_name} trademarks
    FOR    ${i}    IN RANGE    50
        Log To Console                                                ..scrapping page ${i + 1}
        Check Table
        Log To Console                                                ...Reading table data
        Read Table Content
        Log To Console                                                ...Reading table data done ('_')
        Sleep                                                         5
        Log To Console                                                ...saving page ${i + 1} data to excel file
        Outputexcel.Save To Excel                                     ${i + 1}    ${DATAS}    ${target_page_name}  
        Sleep                                                         1
        Log To Console                                                ...saving page data to excel file done ('_')
        Sleep                                                         1
        Log To Console                                                ...scrapping page ${i + 1} done ('_')
        Sleep                                                         1
        Log To Console                                                ...going to next page
                                                       
        Click Link                                                    xpath:${next_link}
        Sleep                                                         40
        Wait Until Element Is Visible                                 xpath://*[@id="dataTable"]/tbody
    END

*** Keywords ***
Open Link
    [Documentation]                                                   Open the browser link to the target page  
    Wait Until Element Is Visible                                     xpath://*[@id="idf"]/div/div[2]/a 
    Go To                                                             ${link_rwanda}
    Sleep                                                             10
    Set Browser Implicit Wait                                         20

Check Table
    [Documentation]                                                   Check if The table is now visible
    Sleep                                                             20
    Wait Until Element Is Visible                                     xpath://*[@id="dataTable"]/tbody

Read Table Content
    [Documentation]                                                   Read the content of the table and print it
    @{tablerow}        Get Web Elements                               xpath://*[@id="dataTable"]/tbody/tr   
    ${tablecount}      Get Element Count                              xpath://*[@id="dataTable"]/tbody/tr                  
    FOR    ${element}    IN    @{tablerow}

        ${image_link}=                   Set Variable                 ${element.find_element_by_tag_name("img").get_attribute("src")}
        ${statu}=                        Set Variable                 ${element.find_element_by_class_name("rs-STLB").text}    
        # ${mark}=                         Set Variable                 ${element.find_element_by_class_name("rs-MKPRLG").text}    ${element.find_element_by_class_name("rs-MK").text}
        ${mark}=                         Set Variable                 ${element.find_element_by_class_name("rs-MK").text}
        ${orig_filing_number}=           Set Variable                 ${element.find_element_by_class_name("rs-AFNB_ORI").text}
        ${filing_date}=                  Set Variable                 ${element.find_element_by_class_name("rs-AFDT").text}    
        ${pub_number}=                   Set Variable                 ${element.find_element_by_class_name("rs-PBNB").text}
        ${pub_date}=                     Set Variable                 ${element.find_element_by_class_name("rs-PBDT").text}
        ${org_reg_number}=               Set Variable                 ${element.find_element_by_class_name("rs-RENB_ORI").text}
        ${reg_date}=                     Set Variable                 ${element.find_element_by_class_name("rs-REDT").text}
        ${nice_classe}=                  Set Variable                 ${element.find_element_by_class_name("rs-NCL").text}
        ${vienna_class}=                 Set Variable                 ${element.find_element_by_class_name("rs-VCL").text}
        ${applicant}=                    Set Variable                 ${element.find_element_by_class_name("rs-APNA").text}
        ${designated_state}=             Set Variable                 ${element.find_element_by_class_name("rs-DESIGNATED_OFF_TXT").text}


        Append To List         ${LINKS}                               ${image_link}
        Append To List         ${STATUS}                              ${statu}
        Append To List         ${MARKS}                               ${mark}
        Append To List         ${ORIGINAL_FILING_NUMBERS}             ${orig_filing_number}
        Append To List         ${FILING_DATES}                        ${filing_date}
        Append To List         ${PUBLICATION_NUMBERS}                 ${pub_number}
        Append To List         ${PUBLICATION_DATES}                   ${pub_date}
        Append To List         ${ORIGINAL_REGISTRATION_NUMBERS}       ${org_reg_number}
        Append To List         ${REGISTRATION_DATES}                  ${reg_date}
        Append To List         ${NICE_CLASSES}                        ${nice_classe}
        Append To List         ${VIENNA_CLASSES}                      ${vienna_class}
        Append To List         ${APPLICANTS}                          ${applicant}
        Append To List         ${DESIGNATED_STATES}                   ${designated_state}

        Collections.Set To Dictionary      ${DATAS}    key    value    image_links                        ${LINKS}  
        Collections.Set To Dictionary      ${DATAS}    key    value    status                             ${STATUS}  
        Collections.Set To Dictionary      ${DATAS}    key    value    marks                              ${MARKS}  
        Collections.Set To Dictionary      ${DATAS}    key    value    original_filing_numbers            ${ORIGINAL_FILING_NUMBERS}  
        Collections.Set To Dictionary      ${DATAS}    key    value    filing_dates                       ${FILING_DATES}  
        Collections.Set To Dictionary      ${DATAS}    key    value    publication_numbers                ${PUBLICATION_NUMBERS}  
        Collections.Set To Dictionary      ${DATAS}    key    value    publication_dates                  ${PUBLICATION_DATES}  
        Collections.Set To Dictionary      ${DATAS}    key    value    original_registration_numbers      ${ORIGINAL_REGISTRATION_NUMBERS}  
        Collections.Set To Dictionary      ${DATAS}    key    value    registration_dates                 ${REGISTRATION_DATES}  
        Collections.Set To Dictionary      ${DATAS}    key    value    nice_classes                       ${NICE_CLASSES}  
        Collections.Set To Dictionary      ${DATAS}    key    value    vienna_classes                     ${VIENNA_CLASSES} 
        Collections.Set To Dictionary      ${DATAS}    key    value    applicants                         ${APPLICANTS}  
        Collections.Set To Dictionary      ${DATAS}    key    value    designated_states                  ${DESIGNATED_STATES}  

    END

Check If Has Next
    [Documentation]                  Check if page has nex page
    Wait Until Element Is Visible    xpath://*[@id="dataTable"]/tbody
    Wait Until Element Is Visible    xpath://*[@id="id1e"]


# Get Total Page Length
#     [Documentation]    Get the length of the page
    






    
    

