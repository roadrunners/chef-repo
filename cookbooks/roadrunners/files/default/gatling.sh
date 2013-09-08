OLDDIR=`pwd`
BIN_DIR=`dirname $0`
cd ${BIN_DIR}/.. && DEFAULT_GATLING_HOME=`pwd` && cd ${OLDDIR}

GATLING_HOME=${GATLING_HOME:=${DEFAULT_GATLING_HOME}}
GATLING_CONF=${GATLING_CONF:=$GATLING_HOME/conf}

export GATLING_HOME GATLING_CONF

echo "GATLING_HOME is set to ${GATLING_HOME}"

JAVA_OPTS="-server -XX:+UseThreadPriorities -XX:ThreadPriorityPolicy=42 -Xms512M -Xmx512M -XX:+HeapDumpOnOutOfMemoryError -XX:+AggressiveOpts -XX:+OptimizeStringConcat -XX:+UseFastAccessorMethods -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+CMSClassUnloadingEnabled -XX:SurvivorRatio=8 -XX:MaxTenuringThreshold=1 -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly ${JAVA_OPTS}"

CLASSPATH="$GATLING_HOME/lib/*:$GATLING_CONF:$GATLING_HOME/user-files:${JAVA_CLASSPATH}"

java $JAVA_OPTS -cp $CLASSPATH io.gatling.app.Gatling $@
