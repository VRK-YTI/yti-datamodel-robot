*** Settings ***
Documentation     Resource file for Datamodel application
Library           SeleniumLibrary

*** Variables ***
${BROWSER}        chrome
${ENVIRONMENT_URL}    https://tietomallit-dev.suomi.fi/
${USER_1}         //a[@class='dropdown-item ng-binding ng-scope'][contains(text(),'Testi Admin')]
${LANGUAGE_EN}    //application/ng-container/navigation-bar/nav/ul/li[3]/div/a[2]/span
${LANGUAGE_FI}    //application/ng-container/navigation-bar/nav/ul/li[3]/div/a[1]/span
${MODEL_1}        Testiautomaatio
#Frontpage
${ADD_MODEL_BTN}    id=modelCreation
${LANGUAGE_DROPDOWN_BTN}    //application/ng-container/navigation-bar/nav/ul/li[3]/a
${IMPERSONATE_USER_DROPDOWN}    //application/ng-container/navigation-bar/nav/ul/li[1]/a
${FRONTPAGE_SEARCH_BOX}    //application/ng-container/div/div/front-page/div/div[1]/div/div/input
#Buttons and links
${ADD_CLASS_BTN}    id=add_new_class_button
${USAGE_BTN}      id=model_http://uri.suomi.fi/datamodel/ns/test_accordion_button
#Model
${SHOW_MODEL_DETAILS_BTN}    id=show_model_details_button
${MODEL_LABEL_INPUT}    id=modelLabel
${MODEL_DESCRIPTION_INPUT}    id=modelComment
${MODEL_PREFIX_INTPUT}    id=modelPrefix
${ADD_CLASSIFICATION}    //application/ng-container/div/div/new-model-page/div/form/fieldset/div[2]/div[2]/classifications-view/h4/button/span
${ADD_CONTRIBUTOR}    //application/ng-container/div/div/new-model-page/div/form/fieldset/div[2]/div[2]/contributors-view/h4/button/span
${SAVE_MODEL_BTN}    //application/ng-container/div/div/new-model-page/div/form/fieldset/div[1]/button[2]/span
${REMOVE_MODEL_BTN}    //*[@id="'model'"]/div/form/fieldset/div/editable-entity-buttons/div/button[4]/span
${CONFIRM_REMOVE_MODEL_BTN}    //div[1]/div/div/div/modal-template/div[3]/div[2]/button[1]

*** Keywords ***
Test Case Setup
    Open Tietomallit
    Set Selenium Speed    0.5
    Sleep    5
    Select user

Select user
    Wait until page contains element    ${IMPERSONATE_USER_DROPDOWN}    timeout=30
    Click element    ${IMPERSONATE_USER_DROPDOWN}
    Wait until page contains element    ${USER_1}
    Click element    ${USER_1}
    Wait Until Page Contains    Testi Admin    timeout=20
    Sleep    2

Open Tietomallit
    Open Browser with Settings
    Wait until page contains    Tietomallit    timeout=20
    Wait until page contains    KIRJAUDU SISÄÄN    timeout=20

Open Browser with Settings
    Run Keyword If    '${BROWSER}' == 'chrome-jenkins'    Open Chrome to Environment
    ...    ELSE IF    '${BROWSER}' == 'chrome-local'    Open Chrome to Environment
    ...    ELSE    Open Browser    ${ENVIRONMENT_URL}    browser=${BROWSER}

Open Chrome to Environment
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --single-process
    Run Keyword If    '${BROWSER}' == 'chrome-jenkins'    Create Webdriver    Chrome    chrome_options=${chrome_options}    executable_path=/usr/local/bin/chromedriver
    ...    ELSE    Create Webdriver    Chrome    chrome_options=${chrome_options}
    Set Window Size    1920    1080
    Go To    ${ENVIRONMENT_URL}

Go back to Tietomallit frontpage and close browsers
    Wait until page contains element    //*[contains(text(), "Etusivu")]    timeout=20
    Click element    //*[contains(text(), "Etusivu")]
    Sleep    2
    Close All Browsers

Go back to Tietomallit frontpage
    Wait until page contains element    //*[contains(text(), "Etusivu")]    timeout=20
    Click element    //*[contains(text(), "Etusivu")]
    Sleep    2

Create Testiautomaatio model
    Wait until page contains element    ${ADD_MODEL_BTN}    timeout=30
    Click Element    ${ADD_MODEL_BTN}
    Click Button    Lisää soveltamisprofiili
    Wait until page contains element    ${MODEL_LABEL_INPUT}    timeout=30
    Input Text    ${MODEL_LABEL_INPUT}    ${MODEL_1}
    Wait until page contains element    ${MODEL_DESCRIPTION_INPUT}    timeout=30
    Input Text    ${MODEL_DESCRIPTION_INPUT}    Tämä on kuvaus
    Wait until page contains element    ${MODEL_PREFIX_INTPUT}    timeout=30
    Input Text    ${MODEL_PREFIX_INTPUT}    test
    Wait until page contains element    ${ADD_CLASSIFICATION}    timeout=30
    Click Element    ${ADD_CLASSIFICATION}
    Wait until page contains element    //*[contains(text(), "Asuminen")]    timeout=30
    Click Element    //*[contains(text(), "Asuminen")]
    Wait until page contains element    ${ADD_CONTRIBUTOR}    timeout=30
    Click Element    ${ADD_CONTRIBUTOR}
    Wait until page contains element    //*[contains(text(), "Testiorganisaatio")]    timeout=30
    Click Element    //*[contains(text(), "Testiorganisaatio")]
    Wait until page contains element    ${SAVE_MODEL_BTN}    timeout=30
    Click Element    ${SAVE_MODEL_BTN}
    Sleep    2

Delete Testiautomaatio model
    Wait until page contains element    ${FRONTPAGE_SEARCH_BOX}    timeout=30
    Input Text    ${FRONTPAGE_SEARCH_BOX}    ${MODEL_1}
    Wait until page contains element    //*[contains(text(), "Testiautomaatio")]    timeout=30
    Click Element    //*[contains(text(), "Testiautomaatio")]
    Wait until page contains element    ${SHOW_MODEL_DETAILS_BTN}    timeout=30
    Click Element    ${SHOW_MODEL_DETAILS_BTN}
    Wait until page contains element    ${REMOVE_MODEL_BTN}    timeout=30
    Click Element    ${REMOVE_MODEL_BTN}
    Wait until page contains element    ${CONFIRM_REMOVE_MODEL_BTN}    timeout=30
    Click Element    ${CONFIRM_REMOVE_MODEL_BTN}
    Sleep    2
    Wait until page contains element    ${FRONTPAGE_SEARCH_BOX}    timeout=30
    Input Text    ${FRONTPAGE_SEARCH_BOX}    ${MODEL_1}
    Wait Until Page Contains    tietomallia    timeout=30
    Sleep    2
    Close All Browsers
