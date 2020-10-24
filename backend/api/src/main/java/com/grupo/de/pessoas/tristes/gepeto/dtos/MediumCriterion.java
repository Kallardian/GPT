package com.grupo.de.pessoas.tristes.gepeto.dtos;


import lombok.Data;

import javax.persistence.*;
//
//@NamedStoredProcedureQuery(
//        name = "",
//        procedureName = "",
//        parameters = {
//
//        }
//)

@Entity
@Table(name = "TB_MEDIUM_CRITERIA")
@Data
public class MediumCriterion {

    @Id
    @Column(name = "ID_MEDIUM")
    private Long idMedium;
    @Column(name = "ID_BIG")
    private Long idBig;
    @Column(name = "NAME_MEDIUM")
    private String nameMedium;
    @Column(name = "DESCRIPTION")
    private String description;
    @Column(name = "TOTAL_VALUE")
    private double totalValue;
}
