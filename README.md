# nifi-windowsservice
Apache NiFi Windows Service Wrapper

Wrapper for running Apache NiFi as a Windows service. This wrapper is using the Apache Commons ProcRun daemon (like Tomcat). 

## Dependencies
1. Maven 3.3+
2. Java 1.8
3. Apache NiFi 

## Build
1. Download and build Apache NiFi using maven. This project needs <code>nifi-bootrap</code> to compile and run, or at least that jar file.
2. The file <code>pom.xml</code> contains a property for the NiFi version. Adjust as necessary before building.
2. Download the source and run: <code>mvn install</code>. An output directory will be created at <code>$root/Dist</code>.

## Installation

1. Copy the <code>nifi-windowsservice.VERSION.jar</code> file into NiFi's </code>/lib/bootstrap</code> directory.
2. Copy everything in <code>/dist/bin</code> to NiFi's <code>/bin</code> folder.
3. Execute <code>/bin/install_service.bat</code>.
4. The service will show up in the service controll manager as "Apache NiFi", with a service name of "nifi-service".

## Uninstallation

Uninstallation can be done in two ways:

1. Execute the Windows service manager commands <code>sc delete nifi-service</code>.
2. Run the command <code>/bin/nifi-service.exe //DS//nifi-service</code>

## Notes

- When NiFi starts up, it unpacks all jars. This may take some time. If you issue the stop command during this time, it may take a while for the service to stop. The apache daemon may even terminiate the process if it is taking too long, but rest assured, the shutdown has been properly initiated.
