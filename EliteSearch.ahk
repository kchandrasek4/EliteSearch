; Set up a hotkey to trigger the text box
^+s:: ; Ctrl + Shift + S
{
    ; Display an input box
    InputBox, userInput, Quick Search, Type your query:
    if ErrorLevel ; If the InputBox was canceled, exit
        return

    ; Open ChatGPT in a new browser window
    Run, chrome.exe --new-window "https://chat.openai.com"
    Sleep 1000 ; Wait for the browser to open (adjust if needed)
    WinActivate, ahk_exe chrome.exe ; Activate the Chrome window
    Sleep 1500 ; Ensure the window is ready
    WinGet, chatGPTID, ID, ahk_exe chrome.exe
    if chatGPTID
        WinMove, ahk_id %chatGPTID%,, 0, 0, A_ScreenWidth/2, A_ScreenHeight ; Move to left half
    Send, {Tab 10} ; Navigate to the input box
    Sleep 200
    SendInput, %userInput% ; Type the query
    Send, {Enter} ; Submit the query

    ; Open Google search in a new browser window
    Run, chrome.exe --new-window "https://www.google.com/search?q=%userInput%"
    Sleep 500 ; Wait for the Google window to open
    WinActivate, ahk_exe chrome.exe ; Activate the Google window
    Sleep 100 ; Ensure the window is ready
    WinGet, googleID, ID, ahk_exe chrome.exe
    if googleID
        WinMove, ahk_id %googleID%,, A_ScreenWidth/2, 0, A_ScreenWidth/2, A_ScreenHeight ; Move to right half

    ; Open File Explorer and search local storage
    Run, explorer.exe "search-ms:query=%userInput%&crumb=location:C:\Users\kaush\"
	; Wait for Explorer to become active
    WinWaitActive, search-ms:

    ; Position File Explorer in the middle at some smaller size
    centerWidth := 900
    centerHeight := 600
    centerX := (A_ScreenWidth - centerWidth) // 2
    centerY := (A_ScreenHeight - centerHeight) // 2
    WinMove, A,, centerX, centerY, centerWidth, centerHeight
}
return
