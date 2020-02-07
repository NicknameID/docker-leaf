package com.sankuai.inf.leaf.common;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.Properties;

public class PropertyFactory {
    private static final Logger logger = LoggerFactory.getLogger(PropertyFactory.class);
    private static final Properties prop = new Properties();
    static {
        try {
            prop.load(PropertyFactory.class.getClassLoader().getResourceAsStream("leaf.properties"));
            for (Object key : prop.keySet()) {
                String propertyKey = key.toString();
                String property = System.getenv(propertyKey);
                if (property != null) {
                    prop.setProperty(propertyKey, property);
                    logger.info(String.format("Property overwrite by environment: %s=%s", propertyKey, property));
                }
            }
        } catch (IOException e) {
            logger.warn("Load Properties Ex", e);
        }
    }
    public static Properties getProperties() {
        return prop;
    }
}
