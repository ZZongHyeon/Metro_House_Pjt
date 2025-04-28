package com.boot.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ApartmentDTO {
	private String name = "래미안 아파트";
	private String location = "강남구 역삼동";
	private String address = "서울특별시 강남구 역삼동 123-45";
	private String distance = "350m";
	private int price = 120000;
	private String rooms = "3";
	private String bathrooms = "2";
	private String floor = "12/15";
	private int buildYear = 2015;
	private int households = 248;
	private String parkingRatio = "1.2대/세대";

}
//const apartments = [
//                    {
//                        id: 1,
//                        name: "래미안 아파트",
//                        location: "강남구 역삼동",
//                        address: "서울특별시 강남구 역삼동 123-45",
//                        distance: "350m",
//                        price: 120000,
//                        size: 84.5,
//                        rooms: "3",
//                        bathrooms: "2",
//                        floor: "12/15",
//                        buildYear: 2015,
//                        households: 248,
//                        parkingRatio: "1.2대/세대",
//                        heatingType: "지역난방",
//                        maintenanceFee: 25,
//                        schools: "역삼초(도보 5분), 역삼중(도보 10분)",
//                        amenities: "편의점, 카페, 마트, 공원",
//                        transport: "2호선 역삼역(5분), 146번 버스(3분)",
//                        lat: parseFloat(stationPlace.y) + 0.002,
//                        lng: parseFloat(stationPlace.x) + 0.001
//                    },

