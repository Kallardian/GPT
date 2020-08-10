package com.grupo.de.pessoas.tristes.gepeto.controllers;

import com.grupo.de.pessoas.tristes.gepeto.dtos.User;
import com.grupo.de.pessoas.tristes.gepeto.repositories.UserRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;

@RestController
@RequestMapping("/users")
public class UserController {

    private UserRepository userRepository = new UserRepository();;

    @GetMapping
    public ResponseEntity getUsers() {

        List<User> users = userRepository.getUsers();

        return ResponseEntity.ok().body(users);
    }

    @GetMapping("/{ra}")
    public ResponseEntity getUserById(@PathVariable() String ra) {

        User user = new User();
        user.setRa(ra);

        user = userRepository.getUserById(user);

        return ResponseEntity.ok().body(user);
    }

    @PostMapping
    public ResponseEntity<?> postUser(@RequestBody User jsonUser) throws URISyntaxException {

        User user = new User();
        user.setRa(jsonUser.getRa());
        user.setFullName(jsonUser.getFullName());
        user.setPassword(jsonUser.getPassword());
        user.setAccess(jsonUser.getAccess());

        userRepository.postUser(user);

        URI location = new URI("/users/" + user.getRa());
        return ResponseEntity.created(location).body(user);
    }

    @PutMapping("/{ra}")
    public String putUser(@PathVariable() String ra) {
        return "updated user";
    }

    @DeleteMapping("/{ra}")
    public ResponseEntity deleteUser(@PathVariable() String ra) {

        User user = new User();
        user.setRa(ra);

        userRepository.deleteUser(user);

        return ResponseEntity.noContent().build();
    }
}
