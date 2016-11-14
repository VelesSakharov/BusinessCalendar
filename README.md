# BusinessCalendar
## I need to develop an application that performs the functions of a business calendar. 
### The application must add notes to the calendar and notify user when it needed. Application should realize API to simplify requests from foreign modules.The application provides the division of roles (head, slave). The head can be optionally assigned by the administrator. Head can add instructions to a slave Calendar. The application will be used by a small staff of employees (up to 10 users). The application will be used a notification system based on web sockets. The application has a graphical user interface. It is supposed to use nginx & unicorn like a server development tools.
* The following classes for the application:
 * User
 * Note
 * Some optional classes needed to correct work with used tools (for example class Ability for CanCanCan)
* While developing I am going to follow next steps:
 * Define entities and add them to the application as models
 * Generate database with defined entities
 * REST architecture development
 * Front-end application development
 * Learning and implementing web sockets to allow the server respond to the client without the client's request
 * Api development to facilitate access to the server-side Task Scheduler
 * 
---
* Тэкставае апісанне праекта работы
 * Проект разрабатывается с использованием фреймворка Ruby on Rails. В проекте используются следующие модели, необходимые для реализации основного функционала: User, Note. Допустимо создание других моделей, необходимых для реализации функционала. Для хранения проекта используется база данных PostgreSQL. Проект использует Ruby версии 2.3.1 и Rails 5.0. Для ролей Admin, Head и User используется CanCanCan. Для авторизации используется Device. Для верстки используется bootstrap. Для отправки уведомлений пользователю предполагается использованиие node.js.
 * Проект представляет собой веб-приложение. Пользователь переходит по адресу приложения и попадает на страницу авторизации. Все функции доступны только после авторизации. Авторизованный пользователь переадрессовывается на страницу заметок. Пользователь, выступающий в роли User, может добавлять, редактировать и удалять заметки исключительно для себя. Head имеет доступ так же к заметкам других пользователей и может добавлять заметки не только для себя, но и для других пользователей. Admin имеет доступ к заметкам всех пользователей и может добавлять, редактировать и удалять заметки любого пользователя. Заметка состоит из названия (title), содержимого (content) и времени, когда она должна напомнить о себе (appointment). Заметка появляется на странице в виде pop-up в момент времени, когда она должна напомнить о себе. Предполаается звуковое уведомление пользователя. Напоминание можно перенести на другое время, для чего пользователь должен указать новое время уведомления.
* Спіс пунктаў запіскі:
 * id
 * title
 * content
 * appointment
* Апісанне классаў у умл
 * ![Img](https://github.com/plufmua/BusinessCalendar/blob/master/models_rails.JPG)
* Апісанне функцыянальных частак у выглядзе схемы
 * 
* Тэхнічныя эксперыменты
 * Sidekiq
 * unicorn + nginx 
 * Mina 
 * Tropo (https://github.com/tropo/reminders)
