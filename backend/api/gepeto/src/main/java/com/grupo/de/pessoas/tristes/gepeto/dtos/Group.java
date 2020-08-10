package com.grupo.de.pessoas.tristes.gepeto.dtos;


import lombok.Data;

import javax.persistence.*;

@Entity
@Table(name = "TB_GROUP")
@Data
public class Group {

    @Id
    @Column(name = "ID_GROUP")
    private Long id_group;
    @Column(name = "NAME_GROUP")
    private String name;
    @Column(name = "GROUP_DESCRIPTION")
    private String description;
    @Column(name = "ID_CLASSROOM")
    private Long id_classroom;
}
