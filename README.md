## Simple Configuration Management Tool

### Usage
Install tool dependencies

```
$ sh bootstrap.sh
```

Install the tool

```
  $ bundle install
```

Run the tool

```
./bin/configure < configuration_file >

$ ./bin/configure example/php-app.json
```

### Architecture

Configuration is a json file that match schema defined in schema/config_schema.json. Resources need to be defined in the desired order of execution. If applying a resource configuration fails all other resource configurations applied will be rolled back. 

Features
1. Allows create and delete of files
2. Installing and removing packages using apt
3. Start, stop and restart services

   


