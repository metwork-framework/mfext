# How to install/upgrade/remove mfext metwork package (with internet access)

## Prerequisites

You must:

- have configured the metwork yum repository. Please see [the corresponding document](configure_metwork_repo.md) document to do that.
- have an internet access on this computer

## Install a metwork package

You just have to execute the following command (as `root` user):

```
yum install metwork-mfext
```

Of course, you can install several metwork packages on the same linux box.




## Uninstall mfext metwork package


To uninstall mfext metwork package, use the following command (still as `root` user):



```
yum remove "metwork-mfext*"
```

## Uninstall all metwork packages

To uninstall all metwork packages, use following root commands:

```
# We stop metwork services
service metwork stop

# we remove metwork packages
yum remove "metwork-*"
```

## Upgrade all metwork packages

The same idea applies to upgrade.

For example, to upgrade all metwork packages on a computer, use following root commands:

```
# We stop metwork services
service metwork stop

# We upgrade metwork packages
yum upgrade "metwork-*"

# We start metwork services
service metwork start
```
