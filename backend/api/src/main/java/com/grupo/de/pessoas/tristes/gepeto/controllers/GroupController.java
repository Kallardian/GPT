package com.grupo.de.pessoas.tristes.gepeto.controllers;

import com.grupo.de.pessoas.tristes.gepeto.dtos.Group;
import com.grupo.de.pessoas.tristes.gepeto.repositories.GroupRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/groups")
public class GroupController {

    private GroupRepository groupRepository = new GroupRepository();

    @GetMapping
    public String showGroups(@PathVariable() int id_classrooms) {
        return "all groups from classroom " + id_classrooms;
    }

    @GetMapping("/{id_group}")
    public ResponseEntity findGroupById(@PathVariable() long id_group) {

        Group group = new Group();
        group.setIdGroup(id_group);

        group = groupRepository.getGroupById(group);

        return ResponseEntity.ok().body(group);
    }

//    @GetMapping("/{ra}")
//    public ResponseEntity getUserById(@PathVariable() String ra) {
//
//        User user = new User();
//        user.setRa(ra);
//
//        user = userRepository.getUserById(user);
//
//        return ResponseEntity.ok().body(user);
//    }

    @PostMapping
    public String createGroup() {
        return "group created";
    }

    @PutMapping("/{id_group}")
    public String updateGroup(@PathVariable() long id_group) {
        return "updated group " + id_group;
    }

    @DeleteMapping("/{id_group}")
    public String deleteGroup(@PathVariable() long id_group) {
        return "group " + id_group + "deleted";
    }
}
