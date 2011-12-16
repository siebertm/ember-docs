Ember Documentation Generator
=============================

A tool to generate documentation for the Ember framework and Ember projects, using the JSDoc format.

Forked from the SproutCore Docs Generator.

**Authors**: Majd Taby, Peter Wagenet

Usage
-----

    gem install ember-docs

### Basic

    ember-docs preview INPUT_DIRECTORY_PATH

This documents the specified directory and then runs a preview server.

### Deploy

    ember-docs generate INPUT_DIRECTORY_PATH -o OUTPUT_DIRECTORY_PATH -t TEMPLATE_PATH

Dependencies
------------

* **node.js**: We use a special (much faster) version of jsdoc-toolkit that requires node.js.

Templates
---------

### docs.sproutcore.com

The template used at docs.sproutcore.com. Designed by Matt Grantham and Ryan Mudryk with additional work by Avrohom Katz.

Credits
------

**jsdoc-toolkit**: Used for the heavy lifting of docs generation

