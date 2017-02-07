# nifi-windowsservice
Apache NiFi Windows Service Wrapper

Wrapper for running Apache NiFi as a Windows service. This wrapper is using the Apache Commons ProcRun daemon (like Tomcat). 

## Build

Download the source and run: <code>mvn install</code>. An output directory will be created at <code>$root/Dist</code>.

## Installation

1. Copy the <code>nifi-windowsservice.VERSION.jar</code> file into NiFi's </code>/lib/bootstrap</code> directory.
2. Copy everything in <code>/dist/bin</code> to NiFi's <code>/bin</code> folder.
3. Execute <code>/bin/install_service.bat</code>.

