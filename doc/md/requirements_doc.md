#  REQUIREMENTS
* [ INTRO](#-intro)
  * [ PURPOSE](#-purpose)
  * [ AUDIENCE](#-audience)
  * [ RELATED DOCUMENTATION](#-related-documentation)
* [ DEPLOYABILITY](#-deployability)
  * [ FULL DEPLOYMENT IN LESS THAN AN HOUR](#-full-deployment-in-less-than-an-hour)
    * [ Deploy by simple unzip](#-deploy-by-simple-unzip)
    * [ Oneliner for prerequisite binaries check](#-oneliner-for-prerequisite-binaries-check)
    * [ Oneliner for Perl modules check](#-oneliner-for-perl-modules-check)
    * [ Installation documentation](#-installation-documentation)
  * [ A FULL APPLICATION CLONE SHOULD BE READY FOR LESS THAN 5 MINUTES](#-a-full-application-clone-should-be-ready-for-less-than-5-minutes)
    * [ Shell script for postgres db creation](#-shell-script-for-postgres-db-creation)
    * [ One liner for single restore](#-one-liner-for-single-restore)
* [ USER-FRIENDLINESS](#-user-friendliness)
  * [ ONELINER SHELL CALLS](#-oneliner-shell-calls)
    * [ Database recreation and DDL scripts run one-liners](#-database-recreation-and-ddl-scripts-run-one-liners)
    * [ Table(s) load via aa single one-liner](#-table(s)-load-via-aa-single-one-liner)
    * [ Testing one-liner call](#-testing-one-liner-call)
    * [ Test messages user](#-test-messages-user)
* [ RELIABILITY AND STABILITY](#-reliability-and-stability)
  * [ ZERO TOLLERANCE TOWARDS CRASHING](#-zero-tollerance-towards-crashing)
  * [ ZERO TOLLERANCE TOWARDS BUGS](#-zero-tollerance-towards-bugs)
  * [ DAILY BACKUPS](#-daily-backups)
  * [ LOGGING](#-logging)
  * [ FULL BACKUP TO THE CLOUD IN LESS THAN 5 MINUTES](#-full-backup-to-the-cloud-in-less-than-5-minutes)
* [ SCALABILITY](#-scalability)
  * [ FEATURE SCALABILITY](#-feature-scalability)
  * [ SETUP SCALABILITY](#-setup-scalability)
  * [ PROJECTS DATABASES SCALABILITY](#-projects-databases-scalability)
* [ PERFORMANCE](#-performance)
  * [ PAGE LOAD MAXIMUM TIME](#-page-load-maximum-time)
  * [ LOGIN, LOGOUT](#-login,-logout)
* [ MULTI-INSTANCE OPERABILITY AND DEPLOYABILITY](#-multi-instance-operability-and-deployability)
  * [ ENVIRONMENT TYPE SELF-AWARENESS](#-environment-type-self-awareness)
  * [ CROSS RUNNING BETWEEN INSTANCES OF DIFFERENT TYPES](#-cross-running-between-instances-of-different-types)
* [ UI REQUIREMENTS](#-ui-requirements)
  * [ CRUDS](#-cruds)
    * [ Execution time](#-execution-time)
    * [ Visual indication](#-visual-indication)
  * [ CLARITY ON ERRORS](#-clarity-on-errors)
* [ SECURITY](#-security)
  * [ AUTHENTICATION](#-authentication)
    * [ Non-athentication mode](#-non-athentication-mode)
    * [ Basic authentication mode](#-basic-authentication-mode)
    * [ Native authentication](#-native-authentication)
    * [ Web SSO authentication](#-web-sso-authentication)
  * [ AUTHRORISATION](#-authrorisation)
* [ DOCUMENTATION](#-documentation)
  * [ DOCUMENTATION COMPLETENESS](#-documentation-completeness)
  * [ DOCUMENTATION AND CODE BASE SYNCHRONIZATION](#-documentation-and-code-base-synchronization)
    * [ requirements push](#-requirements-push)
  * [ PERSONAL RESPONSIBILITY](#-personal-responsibility)
* [ WORKING PRINCIPLES](#-working-principles)




    

##  INTRO


    

###  Purpose
The purpose of this document is to present the requirements set to the Issue-Tracker application for this current version.

    

###  Audience
This document could be of interest for any potential and actual users of the application. Developers and Architects working on the application MUST read and understand this document at least to the extend of their own contribution for the application. 

    

###  Related documentation
This document is part of the Issue-Tracker application documentation-set, which contains the following documents:
 - UserStories - the collection of userstories used to describe "what is desired"
 - SystemGuide - architecture and System description
 - DevOps Guide - a guide for the developers and devops operators
 - Installation Guide - a guide for installation of the application
 - Features and Functionalities - description of the current features and functionalities

All the documents should be updated and redistributed in combination of the current version of the appilication and should be found under the following directories:
doc/md
doc/pdf
doc/xls
according to the file format used for the documentation storage.

    

##  DEPLOYABILITY
The issue-tracker must be easily deployable on any Unix like OS. Windows family based OS'es are explicitly out of the scope of the issue-tracker tool. Any issue-tracker instance should be configurable as easily as possible for the version it has.  

    

###  Full deployment in less than an hour
The full System should be ready for use in a "blank" OS host in less than an hour.

    

####  Deploy by simple unzip
The issue-tracker tool could be deployed by a simply unzip of the full package, which must have all of the documentation and scripts to provide assistance for the setup and the configuration of the tool. 

    

####  Oneliner for prerequisite binaries check
All the binaries which are required for the running of the tool must be checked by a user-friendly binaries prerequisites check script

    

####  Oneliner for Perl modules check
All the required Perl modules, must be verifiable via a single runnable perl script. 

    

####  Installation documentation
The installation of the required mysql and postgres db must be documented in the DevOps guide, which should have both markdown and pdf versions in the doc directory of the deployment package. 

    

###  A full application clone should be ready for less than 5 minutes
A DevOps operator should be able to perform an application clone of the issue-tracker application in less than 5 minutes. 

    

####  Shell script for postgres db creation
The creation of the postgres database should be doable via a single shell call. 

    

####  One liner for single restore
The full data example of a cloned from the issue-tracker db should be loadable with a single shell call. 

    

##  USER-FRIENDLINESS
The interaction with each endpoint and interface of an application instance should be as user-friendly as possble. 
As abstract as it may sound the tool must be multi-dimensionally and vertically integrated regarding the questions what,how and why towards a new person interacting with the tool by the usage of code comments,links from the documentations and uuids to be used for simple grepping from the docs till the source code. 

    

###  Oneliner shell calls
The interaction of the application on the shell should be designed and implemented so that most of the features and bigger entry points should be accessible via one-liners on the shell - for example the testers should be able to lunch all the unit-tests via a single one line call. The integration tests should be triggerable via single oneline call. 

    

####  Database recreation and DDL scripts run one-liners
The developers should be able to create the database via a single oneline call 

    

####  Table(s) load via aa single one-liner
The developers should be able to load a table to the database via a single oneline call 

    

####  Testing one-liner call
The testers and the developers should be able to trigger all the unit or integration tests via a single one-line call. 

    

####  Test messages user
Each test should obey the following convention:
 - short message as descriptive within the context as possible - what is being tested
- a short technical example of the generated entry being tested ( for example a dynamic url )
- a uuid to search for from the Feature document what exactly is being tested within the context of the features description. 

    

##  RELIABILITY AND STABILITY


    

###  Zero tollerance towards crashing
Crashing in normally configured and operating environment must not be tollerated, as soon as any crash has occured a bug must be registered and the bug set with prio towards the features pipeline. 

    

###  Zero tollerance towards bugs
All bugs and inconsistencies must be delt with top priority bypassing new features implementation. 

    

###  Daily backups
Daily backups should be show-stopper for the normal operation of the application - that is if an instance is to be considered as normally operating , the daily backups should be performed automatically as indispensable part of the functioning of the application. 

    

###  Logging
The application shoud support configuratble logging to STDOUT and STDERR for the following levels - debug,info,warn

    

###  Full backup to the cloud in less than 5 minutes
A gull backup of sotware,configuration and data for the issue-tracker and/or another project database should be doable in less than 5 minutes. The backup should be easily searchable from the cloud as well. 

    

##  SCALABILITY


    

###  Feature scalability
The addition of new features should be as scalable as possible. 

    

###  Setup scalability
The creation of new instances of the application should be as easy as possible. 

    

###  Projects databases scalability
Each instance of the issue-tracker application must be able to connect to one or many project databases which DDL schemas matching the current api of the application.

    

##  PERFORMANCE


    

###  Page load maximum time
Each page of the application containing less than 2000 items MUST load for less than 0.3 seconds.
Any new feature which does not meet this requirement should be disregarded or implemented into a clone of the application with different name ( see the cloning / forking section bellow ). 

    

###  Login, logout
Every login and logout operation MUST complete in less than 0.3 seconds in modern network environments

    

##  MULTI-INSTANCE OPERABILITY AND DEPLOYABILITY


    

###  Environment type self-awareness
Each deployed and running instance of the issue-tracker must "know" its own environment type - dev,tst, qas or prd to comply with the multi-instance architecture on a single host. 

    

###  Cross running between instances of different types
The application layers should support as much as possible cross running between different application layer instances and database instances - for example a dev appalication layer should be able to fetch data from a prd database. 

    

##  UI REQUIREMENTS


    

###  CRUDs
The System must provide the needed UI interfaces to Create , Update , Delete and Search items in the system for the users having the privileges for those actions
Any modelled item in the database must be capable for:
 - create 
 - update
 - delete
 - search

    

####  Execution time
The full execution time of any crud operation ( create,update,delete,search) from the end-user of the UI point of view should be less than 0.3 seconds

    

####  Visual indication
The System should not show ok messages , but only error messages, yet the UI should be as responsive that the end-user would easily undertand when an item has been created,updated or deleted.

    

###  Clarity on errors
The UI must present every error in a clear and concise way, so that the end-user would understand that an error has occured, however no msgs should be displayed when the data is saved properly. 

    

##  SECURITY
An well operated instance of the issue-tracker application should have security corresponding to the data sensitivity it is operating on. 

    

###  Authentication
Users should by authenticated via a standard implementation of web tokens. 

    

####  Non-athentication mode
Any issue-tracker instance should support a non-authentication mode - that is all users having http access could perform all the actions on the UI without restrictions

    

####  Basic authentication mode
An issue-tracker instance running under basic authentication mode should support single system user per project database authentication, which must have full acess for the all the available actions via the web ui. 
It is worth noting that each issue-tracker instance having access to data resources should meet the requirements on organisation's level for data access - i.e. if instance dev has full access to the dev,tst,prd project databases there is no rationel of having basic authentication on the prd instance having access to the same dev,tst,prd databases. 

    

####  Native authentication
The issue-tracker should support native web tokens based authentication, by using as login a valid user e-mail and password, stored in the issue-tracker database. 

    

####  Web SSO authentication
The issue-tracker should support authorization

    

###  Authrorisation
The SysAdmin of any instance should be able to add users to the issue-tracker instance. 

    

##  DOCUMENTATION


    

###  Documentation completeness
Each running instance MUST have the following documentation set :
 - Features and Functionalities doc
 - DevOps Guide
 - Requirements
 - SystemGuide
 - UserStories document
 - Installation and Configuration Guide
in at least the md and pdf file formats.

    

###  Documentation and code base synchronization
Each running instance MUST have its required documentation set up-to-date. No undocumented or hidden features are allowed. Should any be missing or misreported a new issue must be created to correct those with top priority. 

    

####  requirements push
Whenever a project database meta-data is updated a new "do releoad the current page" should be pushed on all the clients having currently session in the application …

    

###  Personal responsibility
The whole design of the application as well as each system containing a running instance of it must support the principle for "personal responsibility" - aka for each errror and / or faulty behaviour a concrete person must be available to whom the issue will be assigned. 

    

##  WORKING PRINCIPLES


    
