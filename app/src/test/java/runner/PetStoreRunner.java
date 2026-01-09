package runner;

import com.intuit.karate.junit5.Karate;

public class PetStoreRunner {

    @Karate.Test
    Karate testPetstore() {
        return Karate.run("classpath:features").relativeTo(getClass());
    }
}