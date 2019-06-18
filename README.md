# Diversifying Descartes

Practical exercise for the Diverse Spring Seminar 2019.

The purpose if this exercise is to push the boundaries of [Descartes](https://github.com/STAMP-project/pitest-descartes) outside Java projects. The main goal is to check if it can be successfully applied to projects developed in other JVM languages.

## Steps

1. Select and clone a Github project developed in a JVM language (not Java). Kotlin and Scala are encouraged but others are welcome as well. The project should use JUnit or TestNG. Other testing frameworks are not supported.

2. Build the project and run all the tests. Ideally the test suite should be green.

3. Execute Descartes. Follow the instructions in the following sections according to the build system and language.

4. Analyze the results and report:
    - Issues and crashes during the execution.
    - *Junk* mutations. Mutations that make no sense given the language semantics, for example
    - Interesting mutants that were not caught by the test suite.

## How to apply Descartes?

For this exercise Descartes 1.2.6-SNAPSHOT will be used. The compiled version can be found in the *resources* folder if this repository. 

You can also build the tool from source:

```
git clone https://github.com/STAMP-project/pitest-descartes.git
cd pitest-descartes
mvn clean install
```

For projects using *Maven* and *Gradle* follow the instructions written in the [Descartes' README file](https://github.com/STAMP-project/pitest-descartes/blob/master/README.md) and change the version accordingly. Version 1.2.6-SNAPSHOT should be installed in your local Maven repository. 

### *Scala* projects using *sbt*

Since *Scala* and *sbt* support for PIT are outdated, the PIT command line tool must be used to analyze such a project.
First, add the following code snippet to the `build.sbt` file:

```
lazy val printTestClasspath = taskKey[Unit]("Prints the test classpath")

printTestClasspath := {
  println((fullClasspath in Test).value.files.mkString(":"))
}
```
then execute `sbt-pit.sh`. The first parameter should be the project's directory and the second parameter is a blob referring to the main package in the project.

For example, executing `/sbt-pit.sh scalaj-http-master "scala.http.*"` will run the tool with the `scalaj-http-master` and will analyze all the classes in the `scala.http.*` package.

## Projects

Here is a small list of projects you can try:

**Kotlin**

- https://github.com/hotchemi/khronos
- https://github.com/devromik/black-and-white
- https://github.com/mariomac/kaconf
- https://github.com/thomasnield/kotlin-statistics
- https://github.com/MarcinMoskala/KotlinDiscreteMathToolkit
- https://github.com/traversals/kapsule (Target only *kapsule-core*)
- https://github.com/MicroUtils/kotlin-logging (Target only *kotlin-logging-jvm*)

**Scala**

- https://github.com/scalaj/scalaj-http
- https://github.com/jsuereth/scala-arm
- https://github.com/scalastyle/scalastyle
- https://github.com/knowitall/openregex-scala
- https://github.com/OlivierBlanvillain/scala-xml




