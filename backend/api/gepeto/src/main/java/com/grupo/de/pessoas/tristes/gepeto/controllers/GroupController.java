package com.grupo.de.pessoas.tristes.gepeto.controllers;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/classrooms/{id_classrooms}/groups")
public class GroupController {

    @GetMapping
    public String showGroups(@PathVariable() int id_classrooms) {
        return "all groups from classroom " + id_classrooms;
    }

    @GetMapping("/{id_group}")
    public String findGroup(@PathVariable() long id_group) {
        return "group";
    }

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
