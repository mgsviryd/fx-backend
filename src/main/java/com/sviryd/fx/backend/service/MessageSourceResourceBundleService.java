package com.sviryd.fx.backend.service;

import com.sviryd.fx.backend.config.MessageSourceConfig;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class MessageSourceResourceBundleService {
    private final MessageSourceConfig messageSourceConfig;

    public MessageSourceResourceBundleService(MessageSourceConfig messageSourceConfig) {
        this.messageSourceConfig = messageSourceConfig;
    }

    public Set<String> getKeys(Locale locale) {
        ResourceBundle bundle = ResourceBundle.getBundle(messageSourceConfig.getBasename(), locale);
        return new TreeSet<>(Collections.list(bundle.getKeys()));
    }
}