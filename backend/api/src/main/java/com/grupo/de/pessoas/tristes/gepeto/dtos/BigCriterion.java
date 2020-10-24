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
@Table(name = "TB_BIG_CRITERIA")
@Data
public class BigCriterion {

    @Id
    @Column(name = "ID_BIG")
    private Long idBig;
    @Column(name = "RA")
    private Long ra;
    @Column(name = "YEAR")
    private int year;
}
