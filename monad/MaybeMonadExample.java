package com.reagroup.china;

import java.util.HashMap;
import java.util.Map;
import java.util.function.BiFunction;
import java.util.function.Function;

public class MaybeMonadExample {
    public static void main(String[] args) {
        MaybeMonadExample example = new MaybeMonadExample();
        System.out.println("----------normal style----------");
        System.out.println(example.findCarInsuranceForUser("ddou"));
        System.out.println(example.findCarInsuranceForUser("ddou-no-exist"));

        System.out.println("-----------monad style----------");
        System.out.println(example.findCarInsuranceForUserMonad("ddou"));
        System.out.println(example.findCarInsuranceForUserMonad("ddou-no-exist"));
    }

    private String findCarInsuranceForUserMonad(String ddou) {
        BiFunction<Map<String, String>, String, Maybe<String>> lookup = (map, key) -> map.containsKey(key) ? Maybe.of(map.get(key)) : Maybe.Nothing;

        Maybe<String> result =
            lookup.apply(getIdentityDb(), ddou).bind(
                id -> lookup.apply(getCarRegisterationDb(), id)).bind(
                car -> lookup.apply(getInsuranceDb(), car));
        return result == Maybe.Nothing ? "no-exist" : result.getValue();
    }

    private static Map<String, String> getInsuranceDb() {
        Map<String, String> carInsuranceDb = new HashMap<>();
        carInsuranceDb.put("Ford-111", "insurance for Ford-111");
        carInsuranceDb.put("Toyota-222", "insurance for Toyota-222");
        return carInsuranceDb;
    }

    private static Map<String, String> getCarRegisterationDb() {
        Map<String, String> registerationDb = new HashMap<>();
        registerationDb.put("111", "Ford-111");
        registerationDb.put("222", "Toyota-222");
        return registerationDb;
    }

    private static Map<String, String> getIdentityDb() {
        Map<String, String> identityDb = new HashMap<>();
        identityDb.put("ddou", "111");
        identityDb.put("dddou", "222");
        identityDb.put("ddddou", "333");
        return identityDb;
    }

    public String findCarInsuranceForUser(String name) {
        if (!getIdentityDb().containsKey(name)) {
            return "no-exist";
        }
        String id = getIdentityDb().get(name);

        if (!getCarRegisterationDb().containsKey(id)) {
            return "no-exist";
        }
        String carRegisteration = getCarRegisterationDb().get(id);

        if (!getInsuranceDb().containsKey(carRegisteration)) {
            return "no-exist";
        }
        return getInsuranceDb().get(carRegisteration);
    }
}

class Maybe<T> {
    public static Maybe Nothing = new Maybe<>(null);

    private T value = null;

    private Maybe(T value) {
        this.value = value;
    }

    public static <T> Maybe<T> of(T value) {
        return new Maybe(value);
    }

    public T getValue() {
        return value;
    }

    public Maybe<T> bind(Function<T, Maybe<T>> continuation) {
        if (this == Nothing) {
            return Nothing;
        }
        return continuation.apply(getValue());
    }
}
