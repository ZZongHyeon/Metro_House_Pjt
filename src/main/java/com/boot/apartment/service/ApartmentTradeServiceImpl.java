package com.boot.apartment.service;

import com.boot.apartment.dto.ApartmentTradeDTO;
import com.boot.user.dto.BasicUserDTO;
import com.boot.user.dto.UserDTO;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Service
public class ApartmentTradeServiceImpl implements ApartmentTradeService {
	private static final Logger logger = LoggerFactory.getLogger(ApartmentTradeServiceImpl.class);

	// 캐시 추가
	private Map<String, JSONArray> addressCache = new ConcurrentHashMap<>();
	private Map<String, JSONArray> subwayCache = new ConcurrentHashMap<>();

	// getContent 메소드는 그대로 유지
	private String getContent(Element item, String tagName) {
		NodeList elements = item.getElementsByTagName(tagName);
		if (elements != null && elements.getLength() > 0) {
			return elements.item(0).getTextContent();
		}
		return "";
	}

	// getJSONResponse 메소드에 캐싱 추가
	public JSONArray getJSONResponse(String addressString) {
		// 캐시에서 확인
		JSONArray cachedResult = addressCache.get(addressString);
		if (cachedResult != null) {
			return cachedResult;
		}

		try {
			String encodedAddress = URLEncoder.encode(addressString, "UTF-8");

			String apiUrl = "https://dapi.kakao.com/v2/local/search/address.json?query=" + encodedAddress
					+ "&analyze_type=similar&size=1";

			// API 요청
			URL url = new URL(apiUrl);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod("GET");

			// Authorization 헤더 설정 방식 수정
			String auth = "KakaoAK 11dbdb204c540b726f621d88393a36fb";
			connection.setRequestProperty("Content-Type", "application/json;charset=UTF-8");
			connection.setRequestProperty("Authorization", auth);
			connection.setRequestProperty("KA", "sdk/1.0 os/java lang/ko-KR device/pc");

			int responseCode = connection.getResponseCode();

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
			// 결과를 캐시에 저장
			if (documents != null && documents.length() > 0) {
				addressCache.put(addressString, documents);
			}
			return documents;
		} catch (Exception e) {
			logger.error("주소 검색 API 호출 중 오류 발생: {}", e.getMessage());
			e.printStackTrace();
		}
		return null;
	}

	// getKakaoResponse 메소드에 캐싱 추가
	public JSONArray getKakaoResponse(Double y, Double x) {
		String cacheKey = y + ":" + x;
		JSONArray cachedResult = subwayCache.get(cacheKey);
		if (cachedResult != null) {
			return cachedResult;
		}

		try {
			String encodedAddress = URLEncoder.encode(String.valueOf(x), "UTF-8") + "&y="
					+ URLEncoder.encode(String.valueOf(y), "UTF-8");

			String apiUrl = "https://dapi.kakao.com/v2/local/search/category.json?category_group_code=SW8&x="
					+ encodedAddress + "&sort=distance&size=1";
			// API 요청
			URL url = new URL(apiUrl);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod("GET");

			// Authorization 헤더 설정
			String auth = "KakaoAK 11dbdb204c540b726f621d88393a36fb";
			connection.setRequestProperty("Authorization", auth);

			int responseCode = connection.getResponseCode();
			if (responseCode == 200) {
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

				// 결과를 캐시에 저장
				if (documents != null) {
					subwayCache.put(cacheKey, documents);
				}
				return documents;
			} else {
				System.out.println("API 호출 실패. 응답 코드: " + responseCode);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	private ApartmentTradeDTO processItem(Element item) {
		try {
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
			dto.setFloor(getContent(item, "floor"));
			dto.setBuildYear(getContent(item, "buildYear"));
			dto.setAptDong(getContent(item, "aptDong"));
			dto.setBubun(getContent(item, "bubun"));
			dto.setJibun(getContent(item, "jibun"));
			dto.setRoadNm(getContent(item, "roadNm"));
			dto.setRoadNmBonbun(getContent(item, "roadNmBonbun"));
			dto.setRoadNmBubun(getContent(item, "roadNmBubun"));

			// 주소 조합 및 좌표 조회
			String roadAddress = buildRoadAddress(dto);
			setCoordinatesAndSubwayInfo(dto, roadAddress);

			return dto;
		} catch (Exception e) {
			logger.error("데이터 처리 중 오류 발생: {}", e.getMessage());
			return null;
		}
	}

	private String buildRoadAddress(ApartmentTradeDTO dto) {
		
		String roadAddress = dto.getEstateAgentSggNm() + " " + dto.getUmdNm() + " " + dto.getRoadNm() + " "
				+ Integer.parseInt(dto.getRoadNmBonbun());
//		System.out.println("dto.getEstateAgentSggNm() => "+dto.getEstateAgentSggNm());
		
//		System.out.println("dto.getUmdNm() => "+dto.getUmdNm());
//		System.out.println("dto.getRoadNm() => "+dto.getRoadNm());
//		System.out.println("Integer.parseInt(dto.getRoadNmBonbun() => "+Integer.parseInt(dto.getRoadNmBonbun()));
		
		
		if (!"00000".equals(dto.getRoadNmBubun())) {
			roadAddress += "-" + Integer.parseInt(dto.getRoadNmBubun());
		}
		return roadAddress + " " + dto.getAptNm();
	}

	// 클래스 변수로 실패 카운트 추가
	private int coordinateLookupFailCount = 0;

	private void setCoordinatesAndSubwayInfo(ApartmentTradeDTO dto, String roadAddress) {
	    // 원래 주소로 먼저 시도
	    JSONArray jsonResponse = getJSONResponse(roadAddress);
	    String currentAddress = roadAddress;
	    
	    // 첫 시도가 실패하면 주소 수정 시작
	    while ((jsonResponse == null || jsonResponse.length() == 0) && currentAddress.length() > 0) {
//	        logger.info("좌표 조회 실패, 주소 수정 시도: {}", currentAddress);
	        
	        // 첫 번째 공백이나 쉼표 찾기
	        int spaceIndex = currentAddress.indexOf(" ");
	        int commaIndex = currentAddress.indexOf(",");
	        
	        int cutIndex = -1;
	        if (spaceIndex > 0 && commaIndex > 0) {
	            // 둘 다 존재하면 먼저 나오는 것 선택
	            cutIndex = Math.min(spaceIndex, commaIndex);
	        } else if (spaceIndex > 0) {
	            cutIndex = spaceIndex;
	        } else if (commaIndex > 0) {
	            cutIndex = commaIndex;
	        }
	        
	        // 구분자를 찾았으면 주소 자르기
	        if (cutIndex > 0) {
	            currentAddress = currentAddress.substring(cutIndex + 1).trim();
	            // 수정된 주소로 다시 시도
	            jsonResponse = getJSONResponse(currentAddress);
	        } else {
	            // 더 이상 구분자가 없으면 반복 종료
	            break;
	        }
	    }
	    
	    // 응답 처리 (찾은 경우)
	    if (jsonResponse != null && jsonResponse.length() > 0) {
	        JSONObject jsonObject = jsonResponse.getJSONObject(0);
	        JSONObject address = jsonObject.getJSONObject("address");
	        dto.setLat(address.getDouble("y"));
	        dto.setLng(address.getDouble("x"));

	        // 원래 주소와 다른 경우 성공 로그 기록
	        if (!currentAddress.equals(roadAddress)) {
	            logger.info("수정된 주소로 좌표 조회 성공: {}", currentAddress);
	            logger.info("수정된 주소로 좌표 조회 성공 Y: {}", address.getDouble("y"));
	            logger.info("수정된 주소로 좌표 조회 성공 X: {}", address.getDouble("x"));
	        }

	        JSONArray Response = getKakaoResponse(dto.getLat(), dto.getLng());
	        if (Response != null && Response.length() > 0) {
	            JSONObject KakaoObject = Response.getJSONObject(0);
	            dto.setSubwayStation(KakaoObject.getString("place_name"));
	            dto.setSubwayDistance(KakaoObject.getString("distance"));
	        } else {
	            dto.setSubwayStation("지하철역 없음");
	            dto.setSubwayDistance("0");
	            System.out.println("지하철역 없음");
	        }
	    } else {
	        // 모든 시도 후에도 실패한 경우 카운트 증가
	        coordinateLookupFailCount++;
	        logger.warn("모든 주소 변형 시도 후에도 좌표 조회 실패: {}, 총 실패 횟수: {}", roadAddress, coordinateLookupFailCount);
	    }
	}

	// 실패 카운트를 조회하는 메서드 추가
	public int getCoordinateLookupFailCount() {
	    return coordinateLookupFailCount;
	}

	// 실패 카운트를 초기화하는 메서드 추가
	public void resetCoordinateLookupFailCount() {
	    coordinateLookupFailCount = 0;
	}

	@Override
	public List<ApartmentTradeDTO> getTradeData(String sigunguCode, String yearMonth) {
		try {
			// 파라미터 설정 부분은 동일
			Map<String, String> params = new HashMap<>();
			params.put("LAWD_CD", sigunguCode);
			yearMonth = "202504";
			params.put("DEAL_YMD", yearMonth);
			params.put("serviceKey",
					"22fGZX%2F%2BosjsjNmKoII0P11MjKHTnhRv0qcPtQrOqcgk1L1dS3GIJtsohLG7VM9Qc7wcIKwoyvwWh%2BhsR2nymw%3D%3D");
			params.put("pageNo", "1");
			params.put("numOfRows", "100");

			// API 호출 및 응답 처리 부분은 동일
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
			String apiUrl = "https://apis.data.go.kr/1613000/RTMSDataSvcAptTradeDev/getRTMSDataSvcAptTradeDev?"
					+ sj.toString();

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

			// XML 응답을 파싱
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document document = builder.parse(new ByteArrayInputStream(response.toString().getBytes("UTF-8")));

			// items 아래의 모든 item 엘리먼트를 가져옴
			NodeList items = document.getElementsByTagName("item");

			// 병렬 처리로 변경된 부분
			return IntStream.range(0, items.getLength()).parallel().mapToObj(i -> processItem((Element) items.item(i)))
					.filter(Objects::nonNull).collect(Collectors.toList());

		} catch (Exception e) {
			logger.error("데이터 조회 중 오류 발생: {}", e.getMessage());
			e.printStackTrace();
			return Collections.emptyList();
		}
	}

	@Override
	public List<ApartmentTradeDTO> getTradeData(String sigunguCode, String yearMonth, String numOfRows) {
		try {
			// 파라미터 설정 부분은 동일
			Map<String, String> params = new HashMap<>();
			params.put("LAWD_CD", sigunguCode);
			yearMonth = "202504";
			params.put("DEAL_YMD", yearMonth);
			params.put("serviceKey",
					"22fGZX%2F%2BosjsjNmKoII0P11MjKHTnhRv0qcPtQrOqcgk1L1dS3GIJtsohLG7VM9Qc7wcIKwoyvwWh%2BhsR2nymw%3D%3D");
			params.put("pageNo", "1");
			params.put("numOfRows", numOfRows);

			// API 호출 및 응답 처리 부분은 동일
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
			String apiUrl = "https://apis.data.go.kr/1613000/RTMSDataSvcAptTradeDev/getRTMSDataSvcAptTradeDev?"
					+ sj.toString();

			// 4. GET 요청 보내기
			URL url = new URL(apiUrl);
			System.out.println("apiUrl => " + apiUrl);
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

			// XML 응답을 파싱
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document document = builder.parse(new ByteArrayInputStream(response.toString().getBytes("UTF-8")));

			// items 아래의 모든 item 엘리먼트를 가져옴
			NodeList items = document.getElementsByTagName("item");

			// 병렬 처리로 변경된 부분
			return IntStream.range(0, items.getLength()).parallel().mapToObj(i -> processItem((Element) items.item(i)))
					.filter(Objects::nonNull).collect(Collectors.toList());

		} catch (Exception e) {
			logger.error("데이터 조회 중 오류 발생: {}", e.getMessage());
			e.printStackTrace();
			return Collections.emptyList();
		}
	}

	@Override
	public List<ApartmentTradeDTO> recommend(BasicUserDTO loginUser) {
		if (loginUser != null) {
			String userAddress = loginUser.getUserAddress();

			if (userAddress != null && !userAddress.isEmpty()) {
//                System.out.println("주소: " + userAddress);
				String[] addressParts = userAddress.split(" ");
				if (addressParts.length >= 2) {
					String city = addressParts[0];
					String district = addressParts[1];
					String query = city + " " + district;

					JSONArray jsonResponse = getJSONResponse(query);
					if (jsonResponse != null && jsonResponse.length() > 0) {
						JSONObject jsonObject = jsonResponse.getJSONObject(0);
						JSONObject address = jsonObject.getJSONObject("address");
						String sggcode = address.getString("b_code").substring(0, 5);
//                        System.out.println("추천 시군구 코드: " + sggcode);

						// 추천 아파트 리스트 가져오기
						return getTradeData(sggcode, "202504", "3");
					}
				}
			}
		}
		return new ArrayList<>(); // 아무것도 없을 경우 빈 리스트 반환

	}

}