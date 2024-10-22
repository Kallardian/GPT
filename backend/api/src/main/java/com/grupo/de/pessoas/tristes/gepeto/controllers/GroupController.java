package com.grupo.de.pessoas.tristes.gepeto.controllers;

import com.grupo.de.pessoas.tristes.gepeto.dtos.Classroom;
import com.grupo.de.pessoas.tristes.gepeto.dtos.Group;
import com.grupo.de.pessoas.tristes.gepeto.repositories.GroupRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;

@RestController
@RequestMapping("/groups")
public class GroupController {

    private GroupRepository groupRepository = new GroupRepository();

    //Function
    @GetMapping("/amount/{id_classroom}")
    public ResponseEntity amountOfGroupsByClassroomId(@PathVariable() Long id_classroom) {

        int amount = groupRepository.amountOfGroupsByClassroomId(id_classroom);

        return ResponseEntity.ok().body(amount);
    }

    @GetMapping("/used/{group_id}")
    public ResponseEntity isGroupUsed(@PathVariable() Long group_id) {

        int isUsed = groupRepository.isGroupUsed(group_id);

        if (isUsed == 0) {
            return ResponseEntity.ok().body(false);
        } else return ResponseEntity.ok().body(true);
    }


    //GET
    @GetMapping("/show/{classroom_id}")
    public ResponseEntity getGroups(@PathVariable() Long classroom_id) {

        Classroom classroom = new Classroom();
        classroom.setIdClassroom(classroom_id);

        List<Group> groups = groupRepository.showGroups(classroom);

        return ResponseEntity.ok().body(groups);
    }

    @GetMapping("/{group_id}")
    public ResponseEntity getGroupById(@PathVariable() Long group_id) {

        Group group = new Group();
        group.setIdGroup(group_id);

        group = groupRepository.getGroupById(group);

        return ResponseEntity.ok().body(group);
    }

    //POST
    @PostMapping
    public ResponseEntity<?> postGroup(@RequestBody Group jsonGroup) throws URISyntaxException {

        Group group = new Group();
        group.setGroupTheme(jsonGroup.getGroupTheme());
        group.setDescription(jsonGroup.getDescription());
        group.setIdClassroom(jsonGroup.getIdClassroom());
        group.setRa(jsonGroup.getRa());

        groupRepository.postGroup(group);

        group = groupRepository.getLastGroup();

        URI location = new URI("/groups/" + group.getIdGroup());
        return ResponseEntity.created(location).body(group);
    }

    //PUT
    @PutMapping
    public ResponseEntity updateGroup(@RequestBody Group jsonGroup) {
        Group group = new Group();
        group.setIdGroup(jsonGroup.getIdGroup());
        group.setIdClassroom(jsonGroup.getIdClassroom());
        group.setDescription(jsonGroup.getDescription());
        group.setGroupTheme(jsonGroup.getGroupTheme());

        groupRepository.updateGroup(group);

        return ResponseEntity.ok().body(group);
    }

    //DELETE
    @DeleteMapping("/{group_id}")
    public ResponseEntity deleteGroup(@PathVariable() Long group_id) {

        Group group = new Group();
        group.setIdGroup(group_id);

        groupRepository.deleteGroup(group);

        return ResponseEntity.noContent().build();
    }
}