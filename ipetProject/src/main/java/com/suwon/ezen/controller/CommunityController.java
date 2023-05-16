package com.suwon.ezen.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.suwon.ezen.service.BoardService;
import com.suwon.ezen.vo.BoardVO;
import com.suwon.ezen.vo.ImageTableVO;
import com.suwon.ezen.vo.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/community/*")
@Log4j
public class CommunityController {
	int rno = 0;
	
	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	// 게시글 추가 화면으로 이동
	@GetMapping("insert")
	public ModelAndView startInsertion() {
		ModelAndView model = new ModelAndView();
		model.setViewName("/board/insert");
		
		return model;
	}
	
	// 게시글 추가 화면에서 DB에 데이터 추가하기
	@PostMapping(value = "/insert", consumes = "application/json", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<BoardVO> insertContent(@RequestBody BoardVO vo) {
		System.out.println(vo);
		
		service.insertPost(vo);
		return new ResponseEntity<BoardVO>(vo, HttpStatus.OK);
	}

	// 게시글 읽기 화면으로 이동
	@GetMapping("/read")
    public ModelAndView readContent(@RequestParam("bno") int bno) {
		System.out.println("게시글 읽기: " + bno);
		ModelAndView model = new ModelAndView();
		model.setViewName("/board/read");
		model.addObject("data", service.getOneContent(bno));
		
		// 모든 댓글 가져오기
		List<ReplyVO> replyList = service.getAllReply(bno);
		model.addObject("replyList", replyList);
		
		return model;
	}
	
	// 게시글 수정 화면으로 이동
	@GetMapping("/modify")
	public ModelAndView modifyContent(@RequestParam("bno") int bno) {
		ModelAndView model = new ModelAndView();
		model.setViewName("/board/modify");
		model.addObject("data", service.getOneContent(bno));
		
		return model;
	}
	
	// 게시글 수정하기
	@PutMapping(value = "/modfiy" , consumes = "application/json", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<BoardVO> modifyContent(@RequestBody BoardVO vo) {
		System.out.println("게시글 수정하기: " + vo);
		service.modifyOneContent(vo);
		
		return new ResponseEntity<BoardVO>(vo, HttpStatus.OK);
	}
	
	// 게시글 삭제하기
	@DeleteMapping("/delete")
	public ResponseEntity deleteContent(@RequestBody int bno) {
		System.out.println("게시글 삭제하기: " + bno);
		service.deleteOneContent(bno);
		
		return new ResponseEntity(HttpStatus.OK);
	}
	// 이미지 업로드 페이지로 이동
	@GetMapping("/imageUpload")
	public ModelAndView imageUpload() {
		ModelAndView model = new ModelAndView();
		model.setViewName("/board/upload");
		
		return model;
	}
	
	// 날짜를 문자열로 만들기 위한 메서드
	private String getStringDate() {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String word = dateFormat.format(date);
		
		word.replace("-", "");
		word += "-";
		
		return word;
	}
	
	// 이미지 이름 중복 방지	  
	private String getRandNum() {
	    String dupli = "";
	    
	    for (int i=0;i<8;i++)
	    	dupli += (int)(Math.random()*10);
	    dupli += "_";
	    
	    return dupli;
	}
	
	// 이미지 DB 추가
	@PostMapping("/uploadFile")
	public void uploadImage(MultipartFile[] uploadFile) {
	    System.out.println("들어오니?");
	    // 프로젝트 외부 폴더에서 이미지를 가져오는 것이 보안상 불가능함
	    String uploadFolder = "C:\\upload";
	    
	    System.out.println("폴더명?" + uploadFolder);
	    
//	    // 폴더 생성
//	    File uploadPath = new File(uploadFolder, getFolder());
//	    
//	    if (uploadPath.exists() == false) {
//	    	uploadPath.mkdirs();
//	    }
	    
	    File uploadPath = new File(uploadFolder);
	    
	    if (uploadFile != null) {
	    	System.out.println("빈건 아닌데");
	    }
	    // 파일 저장 
	    for (MultipartFile multipartFile : uploadFile) {
	        String uploadFileName = multipartFile.getOriginalFilename();

	        uploadFileName = getStringDate() + getRandNum() + uploadFileName;
	        System.out.println("업로드할 루트: " + uploadPath);
	        System.out.println("업로드한 파일 이름: " + uploadFileName);
	        File saveFile = new File(uploadPath, uploadFileName);

	        try {
	            multipartFile.transferTo(saveFile);
	            
		        // DB에 이미지 파일 저장
		        ImageTableVO vo = new ImageTableVO();
		        vo.setFileName(uploadFileName);
//		        vo.setUploadPath(uploadPath.toString());
		        service.insertImage(vo);
		        
	        } catch (Exception e) {
	            System.out.println("업로드 실패 => " + uploadFileName + ": " + e.getMessage());
	        }
	    }
	}
	
	@GetMapping("/display")
	@ResponseBody
	public  ResponseEntity<byte[]> getFile(String fileName) { // File 객체를 Byte 배열로 변환하여 header 와 함께 반환함
		log.info("upload controller file display: " + fileName);
		File file = new File("c:\\upload\\" + fileName);
		log.info("file 객체 : "+ file);
		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}

	// 이미지 DB에서 가져오기
	@GetMapping("/downloadFile")
	public ResponseEntity<ImageTableVO> downloadImage(String fileName) {
		System.out.println("파일 이름: " + fileName);
		ImageTableVO vo = service.selectImage(fileName);
//		String merge = vo.getUploadPath() + "\\" + vo.getFileName();
//		System.out.println(merge);
		return new ResponseEntity<ImageTableVO>(vo, HttpStatus.OK);
		// 인터넷 보고 추가한거
//		Resource resource = new FileSystemResource(merge);
//		HttpHeaders header = new HttpHeaders();
//		Path filePath = null;
//		
//		try {
//			filePath = Paths.get(vo.getUploadPath() + vo.getFileName());
//			header.add("Context-Type", Files.probeContentType(filePath));
//		}
//		catch(Exception e) {
//			e.printStackTrace();
//		}
//		
//		return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
	}
	
	// 댓글 추가
	@PostMapping(value = "/insertReply")
	public ResponseEntity<String> insertReply(@RequestParam("bno") int bno, @RequestParam("id") String id, 
			@RequestParam("reply") String reply, @RequestParam(value = "uploadFile", required = false) MultipartFile[] uploadFile) {
		rno += 1;
		System.out.println("들어오니?");
		System.out.println("rno: " + rno);
		// Reply DB에 저장
		ReplyVO vo = new ReplyVO();
//	    vo.setBno(bno);
//	    vo.setId(id);
//	    vo.setReply(reply);
//	    vo.setRno(rno);
//	    
		// 업로드된 파일 처리
	    if (uploadFile != null) {
	    	vo.setIsFileExist("Y");
	    	
		    String uploadFolder = "C:\\upload\\replyImage";
		    File uploadPath = new File(uploadFolder);

		    for (MultipartFile multipartFile : uploadFile) {
		        String uploadFileName = multipartFile.getOriginalFilename();

		        uploadFileName = getStringDate() + getRandNum() + uploadFileName;
		        System.out.println("업로드할 루트: " + uploadPath);
		        System.out.println("업로드한 파일 이름: " + uploadFileName);
		        File saveFile = new File(uploadPath, uploadFileName);

		        try {
		            multipartFile.transferTo(saveFile);
		            
			        // ImageTable DB에 이미지 파일 저장
			        ImageTableVO imgVo = new ImageTableVO();
			        imgVo.setFileName(uploadFileName);
//			        imgVo.setBno(bno);
//			        imgVo.setId(id);
//			        imgVo.setRno(rno);
			        
			        service.insertImage(imgVo);
		        } catch (Exception e) {
		            System.out.println("업로드 실패 => " + uploadFileName + ": " + e.getMessage());
		        }
		    }
	    }
	    else {
	    	vo.setIsFileExist("N");
	    }
	    
	    service.insertReply(vo);
	    
	    return new ResponseEntity<String>("전송 완료", HttpStatus.OK);
	}
	    

}
