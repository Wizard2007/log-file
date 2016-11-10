# ruby-library ruby  garage 
Component tLogFile designed for easy addition of application functionality logging. Logging done in text files. Component tLogFile designed for easy addition of application functionality logging. Logging done in text files. Recording held in accordance with configurable options. Recording held in accordance with configurable options. 

1. Installation

1.1. Components -> Install Packages ... Components -> Install Packages ... -> Add -> Add 
1.2. Select TtLogFile.bpl, click Open Select TtLogFile.bpl, click Open 
1.3. OK 

2.1. File -> Open Project ... File -> Open Project ... 
2.2. Select TtLogFile.dpk, click Open Select TtLogFile.dpk, click Open 
2.3. Compile TtLogFile.dpk Compile TtLogFile.dpk 
2.4. Install TtLogFile.dpk Install TtLogFile.dpk 
2.5. OK 

2. Description of the properties demo locate at ..\Demo
Compnent located on the tab TTComponents 
Properties:
    property Active - true - an entry in the log is, false-log off
    property FileName - Prefix log
    property KeepOpened - true - file is not closed after each entry
    property FileDir - The path where to store log file
    property FileExt: - Extension to log file
    property FormatDateTimeToLog - date and time format added to the log
    property FormatDateStr - the date format of the time, added to the file name
    property AddDateTimeToLog - true - to write to the file date and time, false - do not write
    property AddMessageTypeToLog - true - to write to a file type of message, false - do not write
    property IniFileName - the path to the ini - file, which will store the settings for the tether logs
    property IniFileSectionName - Name of sections in the ini - file, from which will be required to pick up the settings for logirovnaiya
    property LogLevel - (llINFO - write to the log messages, llERROR - write to log the error message, llTRACE - write to log messages to trace)
    property isShowMessageOnError - {true - Show message on error, false - don't show}
Methods;
    function Prepare: Boolean - The initialization function with the log files.
    procedure Add (ALevel: TLogLevel; AText: string); - Function to write to the log file messages
    procedure AddFile (ALevel: TLogLevel; AFilePath: string); - Function to write a data file from over text file.
    procedure AddStrings (ALevel: TLogLevel; AStrings: TStrings); - Function to write the set of lines in the log file
    procedure AddFromStream (ALevel: Tloglevel; AStream: TStream; ABufSize: Integer); - Function to write from a stream to a log file
    procedure SaveToStream (AStream: TStream; const AFileName: string =''); - I function to save the log file in a stream.
    function LoadFromIniFile: Boolean; - Function to load the parameters of the logging file.
----------------------------------------------- 
Example ini-file: 
[Log]
; Logging level uazyvaet message containing any type will be written
; INFO = 1 - information;
; ERROR = 2 - Errors;
; TRACE = 3 - Debug;
LogLevel = 4
; Name prefix
FileName = Log
; 1 - to write to log file 0 - do not write to log file
Active = 1
; Keep a file open
KeepOpened = 1
; Add to Kajo record to a log file date and time
AddDateTimeToLog = 1
; Expanding the log file
FileExt =.log
; Date format of time in the filename.
FormatDateStr = YYYYMMDD
; The path to the log
; folder Log at the current folder
FileDir = .\Log
; Date format of time in the log
;dd/mm/yy hh:mm:ss = 09/02/49 01:02:03
;mmm = Feb
;mmmm = February
;ddd = Th
;dddd = Thursday
;ddddd = 09/02/2049
;dddddd = 09 february 2049
;hhampm = 01AM
;t = 01:02
;tt = 01:02:03
FormatDateTimeToLog = dd/mm/yyyy hh:mm:ss
; true - write to log file message type, false - dont write
AddMessageTypeToLog = 1
