# BusinessCalendar
## I need to develop an application that performs the functions of a business calendar. 
### The application must add notes to the calendar and notify user when it needed. Application should realize API to simplify requests from foreign modules.The application provides the division of roles (head, slave). The head can be optionally assigned by the administrator. Head can add instructions to a slave Calendar. The application will be used by a small staff of employees (up to 10 users). The application will be used a notification system based on web sockets. The application has a graphical user interface. It is supposed to use nginx & unicorn like a server development tools.
* The following classes for the application:
 ** User
 ** Note
 ** Some optional classes needed to correct work with used tools (for example class Ability for CanCanCan)
* While developing I am going to follow next steps:
 ** Define entities and add them to the application as models
 ** Generate database with defined entities
 ** REST architecture development
 ** Front-end application development
 ** Learning and implementing web sockets to allow the server respond to the client without the client's request
 ** Api development to facilitate access to the server-side Task Scheduler
