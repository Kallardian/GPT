package com.grupo.de.pessoas.tristes.gepeto.dtos;


import lombok.Data;

import javax.persistence.*;

@Entity
@Table(name = "TB_SMALL_CRITERIA")
@Data
public class SmallCriterion {

    @Id
    @Column(name = "ID_LITTLE")
    private Long id_little;
    @Column(name = "ID_MEDIUM")
    private Long id_medium;
    @Column(name = "NAME_LITTLE")
    private String name_little;
    @Column(name = "TOTAL_VALUE")
    private double total_value;
}
