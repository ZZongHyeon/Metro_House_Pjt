package com.boot.service;

import com.boot.dto.ApartmentTradeDTO;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.*;

@Service
public class ApartmentTradeServiceImpl implements ApartmentTradeService {

    private String getContent(Element item, String tagName) {
        NodeList elements = item.getElementsByTagName(tagName);
        if (elements != null && elements.getLength() > 0) {
            return elements.item(0).getTextContent();
        }
        return "";
    }
    // 카카오 API로 위도/경도 조회하는 메소드
    public JSONArray getJSONResponse(String addressString) {
        try {
            String encodedAddress = URLEncoder.encode(addressString, "UTF-8");
            String apiUrl = "https://dapi.kakao.com/v2/local/search/address.json?query=" + encodedAddress;

            // API 요청
            URL url = new URL(apiUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");

            // Authorization 헤더 설정 방식 수정
            String auth = "KakaoAK 11dbdb204c540b726f621d88393a36fb";
            connection.setRequestProperty("Content-Type", "application/json;charset=UTF-8");
            connection.setRequestProperty("Authorization", auth);
            connection.setRequestProperty("KA", "sdk/1.0 os/java lang/ko-KR device/pc");

            // 디버깅을 위한 요청 정보 출력
            System.out.println("요청 URL: " + apiUrl);
            System.out.println("Authorization 헤더: " + auth);

            int responseCode = connection.getResponseCode();
            System.out.println("응답 코드: " + responseCode);

            if (responseCode == 401) {
                System.out.println("인증 실패: API 키를 확인해주세요.");
                return null;
            }

            if (responseCode != 200) {
                System.out.println("API 호출 실패. 응답 코드: " + responseCode);
                // 에러 응답 내용 확인
                BufferedReader errorReader = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
                String errorLine;
                StringBuilder errorResponse = new StringBuilder();
                while ((errorLine = errorReader.readLine()) != null) {
                    errorResponse.append(errorLine);
                }
                errorReader.close();
                System.out.println("에러 응답: " + errorResponse.toString());
                return null;
            }

            // 응답 받기
            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // JSON 응답 파싱
            JSONObject jsonResponse = new JSONObject(response.toString());
            JSONArray documents = jsonResponse.getJSONArray("documents");

            return documents;

        } catch (Exception e) {
            System.out.println("에러 발생: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }





    @Override
    public List<ApartmentTradeDTO> getTradeData(String sigunguCode, String yearMonth) {
        List<ApartmentTradeDTO> tradeList = new ArrayList<>();
        // TODO Auto-generated method stub
        // 1. 파라미터를 키-값 쌍으로 관리
        Map<String, String> params = new HashMap<>();
        params.put("LAWD_CD", sigunguCode);
        params.put("DEAL_YMD", yearMonth);
        params.put("serviceKey", "22fGZX%2F%2BosjsjNmKoII0P11MjKHTnhRv0qcPtQrOqcgk1L1dS3GIJtsohLG7VM9Qc7wcIKwoyvwWh%2BhsR2nymw%3D%3D");
        params.put("pageNo", "1");
        params.put("numOfRows", "100");

        try {
            // 2. 쿼리스트링 생성
            StringJoiner sj = new StringJoiner("&");
            for (Map.Entry<String, String> entry : params.entrySet()) {
                // 이미 인코딩된 serviceKey는 그대로 사용, 그 외는 인코딩
                if ("serviceKey".equals(entry.getKey())) {
                    sj.add(entry.getKey() + "=" + entry.getValue());
                } else {
                    sj.add(entry.getKey() + "=" + URLEncoder.encode(entry.getValue(), "UTF-8"));
                }
            }

            // 3. API URL 조립
            String apiUrl = "https://apis.data.go.kr/1613000/RTMSDataSvcAptTradeDev/getRTMSDataSvcAptTradeDev?" + sj.toString();

            // 4. GET 요청 보내기
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            // 5. 응답 읽기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line).append("\n");
            }
            br.close();

            // 6. 결과 출력
            System.out.println(response.toString());

            // XML 응답을 파싱
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document document = builder.parse(new ByteArrayInputStream(response.toString().getBytes("UTF-8")));

            // items 아래의 모든 item 엘리먼트를 가져옴
            NodeList items = document.getElementsByTagName("item");

            // 각 item을 DTO로 변환
            for (int i = 0; i < items.getLength(); i++) {
                Element item = (Element) items.item(i);
                ApartmentTradeDTO dto = new ApartmentTradeDTO();

                // 기본 정보 설정
                String aptNm = getContent(item, "aptNm");
                String sggNm = getContent(item, "estateAgentSggNm");

                dto.setAptNm(aptNm);
                dto.setDealAmount(getContent(item, "dealAmount"));
                dto.setBonbun(getContent(item, "bonbun"));
                dto.setExcluUseAr(getContent(item, "excluUseAr"));
                dto.setEstateAgentSggNm(sggNm);
                dto.setUmdNm(getContent(item, "umdNm"));
                dto.setSggCd(getContent(item, "sggCd"));
                dto.setUmdCd(getContent(item, "umdCd"));
                dto.setDealYear(getContent(item, "dealYear"));
                dto.setDealMonth(getContent(item, "dealMonth"));
                dto.setDealDay(getContent(item, "dealDay"));
                dto.setFloor(getContent(item, "floor"));
                dto.setBuildYear(getContent(item, "buildYear"));
                dto.setCdealType(getContent(item, "cdealType"));
                dto.setCdealDay(getContent(item, "cdealDay"));
                dto.setDealingGbn(getContent(item, "dealingGbn"));
                dto.setRgstDate(getContent(item, "rgstDate"));
                dto.setAptDong(getContent(item, "aptDong"));
                dto.setSlerGbn(getContent(item, "slerGbn"));
                dto.setBuyerGbn(getContent(item, "buyerGbn"));
                dto.setLandLeaseholdGbn(getContent(item, "landLeaseholdGbn"));
                dto.setAptSeq(getContent(item, "aptSeq"));
                dto.setBubun(getContent(item, "bubun"));
                dto.setLandCd(getContent(item, "landCd"));
                dto.setRoadNm(getContent(item, "roadNm"));
                dto.setRoadNmBonbun(getContent(item, "roadNmBonbun"));
                dto.setRoadNmBubun(getContent(item, "roadNmBubun"));
                dto.setRoadNmCd(getContent(item, "roadNmCd"));
                dto.setRoadNmSeq(getContent(item, "roadNmSeq"));
                dto.setRoadNmSggCd(getContent(item, "roadNmSggCd"));
                dto.setRoadNmBCd(getContent(item, "roadNmBCd"));
                dto.setJibun(getContent(item, "jibun"));





                // 주소 조합 및 좌표 조회
                String roadAddress = dto.getEstateAgentSggNm() + " "
                        + dto.getRoadNm() + " "
                        + Integer.parseInt(dto.getRoadNmBonbun());
// 필요시 부번 추가
                if (!"00000".equals(dto.getRoadNmBubun())) {
                    roadAddress += "-" + Integer.parseInt(dto.getRoadNmBubun());
                }
                roadAddress += " " + dto.getAptNm();

                JSONArray jsonResponse = getJSONResponse(roadAddress);

                if (jsonResponse != null && jsonResponse.length() > 0) {
                    JSONObject jsonObject = jsonResponse.getJSONObject(0);
                    JSONObject address = jsonObject.getJSONObject("address");
                    dto.setLat(address.getDouble("y"));
                    dto.setLng(address.getDouble("x"));
                } else {
                    System.out.println("좌표 조회 실패: " + roadAddress);
                }

                System.out.println("Apartment Name: " + dto.getAptNm());
                System.out.println("Deal Amount: " + dto.getDealAmount());
                System.out.println("Bonbun: " + dto.getBonbun());
                System.out.println("Exclu Use Ar: " + dto.getExcluUseAr());
                System.out.println("Estate Agent Sgg Nm: " + dto.getEstateAgentSggNm());
                System.out.println("Latitude: " + dto.getLat());
                System.out.println("Longitude: " + dto.getLng());

                tradeList.add(dto);
            }


        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return tradeList;
    }
}