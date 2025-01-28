package com.sviryd.fx.backend.service;

import jakarta.validation.constraints.NotNull;
import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceResolvable;
import org.springframework.context.NoSuchMessageException;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;

import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

@Service
public class MessageI18nService implements MessageSource {
    private final MessageSource messageSource;
    private final MessageSourceResourceBundleService messageSourceResourceBundleService;

    public MessageI18nService(MessageSource messageSource, MessageSourceResourceBundleService messageSourceResourceBundleService) {
        this.messageSource = messageSource;
        this.messageSourceResourceBundleService = messageSourceResourceBundleService;
    }

    @Override
    public String getMessage(@NotNull String code, @Nullable Object[] args, @Nullable String defaultMessage, @NotNull Locale locale) {
        return messageSource.getMessage(code, args, defaultMessage, locale);
    }

    @NotNull
    @Override
    public String getMessage(@NotNull String code, @Nullable Object[] args, @NotNull Locale locale) throws NoSuchMessageException {
        return messageSource.getMessage(code, args, locale);
    }

    @NotNull
    @Override
    public String getMessage(@NotNull MessageSourceResolvable resolvable, @NotNull Locale locale) throws NoSuchMessageException {
        return messageSource.getMessage(resolvable, locale);
    }

    public Map<String, String> getMessages(Locale locale) {
        Set<String> keys = getKeys(locale);
        TreeMap<String, String> messages = new TreeMap<>();
        keys.forEach(key -> messages.put(key, getMessage(key, null, locale)));
        return messages;
    }

    public Set<String> getKeys(Locale locale) {
        return messageSourceResourceBundleService.getKeys(locale);
    }
}
