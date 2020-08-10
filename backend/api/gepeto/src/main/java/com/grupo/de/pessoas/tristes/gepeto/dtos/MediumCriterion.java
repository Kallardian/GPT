package com.grupo.de.pessoas.tristes.gepeto.dtos;


import lombok.Data;

import javax.persistence.*;

@Entity
@Table(name = "TB_MEDIUM_CRITERIA")
@Data
public class MediumCriterion {

    @Id
    @Column(name = "ID_MEDIUM")
    private Long id_medium;
    @Column(name = "ID_BIG")
    private Long id_big;
    @Column(name = "NAME_MEDIUM")
    private String name_medium;
    @Column(name = "DESCRIPTION")
    private String description;
    @Column(name = "TOTAL_VALUE")
    private double total_value;
}
