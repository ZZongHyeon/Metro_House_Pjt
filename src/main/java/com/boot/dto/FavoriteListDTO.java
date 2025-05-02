package com.boot.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FavoriteListDTO {

        private Long listId;                // LISTID (NUMBER, auto-increment)
        private String userNumber;              // USERID
        private String sggcd;               // SGGCD
        private String umdnm;               // UMDNM
        private String aptnm;               // APTNM
        private String jibun;               // JIBUN
        private String excluusear;          // EXCLUUSEAR
        private String dealYear;            // DEALYEAR
        private String dealMonth;           // DEALMONTH
        private String dealDay;             // DEALDAY
        private String dealAmount;          // DEALAMOUNT
        private String floor;               // FLOOR
        private String buildYear;           // BUILDYEAR
        private String cdealType;           // CDEALTYPE
        private String cdealDay;            // CDEALDAY
        private String dealingGbn;          // DEALINGGBN
        private String estateAgentSggnm;    // ESTATEAGENTSGGNM
        private String rgstDate;            // RGSTDATE
        private String aptDong;             // APTDONG
        private String slerGbn;             // SLERGBN
        private String buyerGbn;            // BUYERGBN
        private String landLeaseHoldGbn;    // LANDLEASEHOLDGBN
        private String aptSeq;              // APTSEQ
        private String bonbun;              // BONBUN
        private String bubun;               // BUBUN
        private String landCd;              // LANDCD
        private String roadNm;              // ROADNM
        private String roadNmBonbun;        // ROADNMBONBUN
        private String roadNmBubun;         // ROADNMBUBUN
        private String roadNmCd;            // ROADNMCD
        private String roadNmSeq;           // ROADNMSEQ
        private String roadNmSggcd;         // ROADNMSGGCD
        private String roadNmBcd;           // ROADNMBCD
        private String umdcd;               // UMDCD
        private Double lat;                 // LAT
        private Double lng;                 // LNG
        private String subwayStation;       // SUBWAYSTATION
        private String subwayDistance;      // SUBWAYDISTANCE
}
