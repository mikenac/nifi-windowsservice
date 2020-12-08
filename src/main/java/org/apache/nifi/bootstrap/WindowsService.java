/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.apache.nifi.bootstrap;

import java.io.IOException;
import java.io.File;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *<p>Windows service wrapper for NiFi bootstrapping</p>
 * @author mike-nacey
 */
public class WindowsService {
    public static final String DEFAULT_CONFIG_FILE = "./conf/bootstrap.conf";
   // used for logging all info. These by default will be written to the log file
    private static final Logger commandLogger = LoggerFactory.getLogger("org.apache.nifi.bootstrap.Command");
    private static final File bootstrapConfigFile = getBootstrapConfFile();
    private static RunNiFi bootstrap;

    public static void start (String[] args) throws IOException, InterruptedException{
        boolean verbose = isVerbose(args);
   
        commandLogger.info("WindowsService-Starting NiFi");
        bootstrap = new RunNiFi(getBootstrapConfFile());
        bootstrap.start(true);
        commandLogger.info("WindowsService-NiFi run method exiting.");
    }
    
    public static void stop(String[] args) throws IOException, InterruptedException {
        commandLogger.info("WindowsService-Stopping NiFi");
        // disable this or NiFi will try to restart itself
        bootstrap.setAutoRestartNiFi(false);
        bootstrap.stop();
        commandLogger.info("WindowsService-NiFi stop process completed.");
    }
    
    private static boolean isVerbose (String[] args) {
        if (args.length == 1) {
            if (args[0].equalsIgnoreCase("-verbose")) {
                return true;
            }
        }
        return false;
    }
    
    // Copied from RunNiFi so as not to require modification
    private static File getBootstrapConfFile() {
        String configFilename = System.getProperty("org.apache.nifi.bootstrap.config.file");

        if (configFilename == null) {
            final String nifiHome = System.getenv("NIFI_HOME");
            if (nifiHome != null) {
                final File nifiHomeFile = new File(nifiHome.trim());
                final File configFile = new File(nifiHomeFile, DEFAULT_CONFIG_FILE);
                configFilename = configFile.getAbsolutePath();
            }
        }

        if (configFilename == null) {
            configFilename = DEFAULT_CONFIG_FILE;
        }

        final File configFile = new File(configFilename);
        return configFile;
    }
}

