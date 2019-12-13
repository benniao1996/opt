#!/bin/bash
mv /opt/tomcat/lottery-im-core/bin/tomcat-native.tar.gz /usr/local/src &&
cd /usr/local/src && 
tar -xzvf tomcat-native.tar.gz &&
cd tomcat-native-1.2.19-src/native/ && ./configure --with-apr=/usr/local/apr --with-java-home=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.232.b09-0.el7_7.x86_64 && make -j 4 && make install
