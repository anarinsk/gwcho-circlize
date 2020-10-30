## Generating Chord Diagram with R

## Info 

- repo: [https://github.com/anarinsk/gwcho-circlize](https://github.com/anarinsk/gwcho-circlize)
- description: 코드 다이어그램 생성을 위한 RStudio Binder 구동 및 R 코드 

## 요약 


- url을 눌러 mybinder.org에 필요한 세팅을 마치고 RStudio를 띄운다. 
	- 처음 띄울 때는 오래 걸리니 당황하지 마시라. 
- 원자료를 업로드 한다. 
  - 전공 &rarr; 직업을 나타내는 csv 테이블 
  - 전공 컬러 csv 테이블
- 코드를 실행해서 코드 다이어그램을 얻는다. 
  - 화면은 확인하는 용도만 (해상도가 나쁘더라도 걱정 마시라!)
  - pdf로 생성한 후 다운로드 받아서 활용 




## mybinder에서 서버 생성


아래 링크를 클릭한다. 
[https://mybinder.org/v2/gh/anarinsk/gwcho-circlize/main?urlpath=rstudio](https://mybinder.org/v2/gh/anarinsk/gwcho-circlize/main?urlpath=rstudio)


![](https://github.com/anarinsk/gwcho-circlize/blob/main/images/gwcho_7.png?raw=true){: style="textalign:center; " width="700"}  


- 링크를 클릭하면 bider.org 서비스가 필요한 서버를 생성한다. 
- 처음에는 상당한 시간이 소요 (5분~10분)
- 일단 한번 생성된 이후에는 일정 시간 동안 활용하면 바로 사라지지는 않는다. 


## RStudio 론칭 


아래 화면과 같이 RStudio가 론칭되면 서버가 잘 생성된 것이다. 


![](https://github.com/anarinsk/gwcho-circlize/blob/main/images/gwcho_8.png?raw=true){: style="textalign:center; " width="700"}  


## Hands-on Test 


일단 잘 되는지 확인해보자. 


- 4분면로 나뉜 창에서 4분면에 `Files` 탭으로 간다. 


![](https://github.com/anarinsk/gwcho-circlize/blob/main/images/gwcho_2.png?raw=true){: style="textalign:center; " width="500"}  




- `circlize_rtc.R`을 읽는다. 
- 2분면에서 아래 그림과 같이 여기까지 마우스 드래그 앤 드롭으로 선택한 후, `Run` 버튼을 누른다. 


![](https://github.com/anarinsk/gwcho-circlize/blob/main/images/gwcho_4.png?raw=true){: style="textalign:center; " width="700"}  


- 여기까지 하면 준비가 완료된 것이다. 
- 실행이 잘 되는지 보기 위해서 샘플로 2개의 코드를 넣어 놓았다. 


```R
wrap_oneside_chord("test_data.csv", c("프리랜서"), alpha_h=0.7, alpha_l=0.07, save_pdf=F) 
wrap_oneside_chord("test_data.csv", c("공학", "인문사회"), alpha_h=0.7, alpha_l=0.07, save_pdf=T) 
```


- 해당 줄 끝에 커서를 대고 역시 `Run`을 누른다. 
  
- 첫번째 코드는 직업을 선택하고 이 직업이 어느 전공에서 왔는지를 하일라이팅해주는 코드 다이어그램이다. 화면 상에만 나타난다. 

![](https://github.com/anarinsk/gwcho-circlize/blob/main/images/gwcho_5.png?raw=true){: style="textalign:center border:2px;" width="700"} 



- 두번째 코드는 전공을 선택하고 이 전공이 어느 직업으로 가는지를 하일라이팅해주는 코드 다이어그램이다. pdf로 저장된다. 
  - 저장된 pdf는 `Files` 탭에서 확인할 수 있다. 
  - 필요하면 여러 파일을 선택한 후 `More` -> `Export`로 다운로드해서 쓰면 된다. 




## 함수 해설 


그래프를 생성해주는 함수는 `wrap_oneside_chord`이다. 각각의 인자의 의미는 아래와 같다. 


wrap_oneside_chord(csv_name, filtering_elements, alpha_h, alpha_l, save_pdf) 


- `csv_name`: csv 파일의 이름을 나타낸다. 필요한 파일을 `Files`에서 업로드한 후 해당 이름으로 바꿔서 실행하면 된다. 업로드는 역시 4사분면의 업로드 버튼을 활용하면 된다. 
- `filtering_elements`: 직업 혹은 전공을 선택하는 인자이다. 
  - 복수 선택이 가능하다. 단 `c("A", "B")`의 형태로 써줘야 한다. 
- alpha_h: 하일라이트되는 코드 선의 강도를 나타낸다. (선을 진하게 하고 싶으면 값을 높이면 된다. 0~1)
- alpha_l: 하일라이트되지 않는 코드 선의 강도를 나탄낸다. 
- save_pdf: 결과를 화면으로 볼지 pdf로 볼지를 나타낸다. (`T`/`F`)




## 소스 데이터 포맷 

제대로 된 작업을 위해서는 두 개의 소스 데이터가 제공되어야 한다. 

### 전공-직업이동 데이터 

전공-직업이동을 나타내는 csv 파일이 필요하다. 
- csv 데이터 포맷은 보는 그대로 이다. 
	- 첫 행에는 1열을 제외하고 직업이 들어간다. 
	- 첫 열에는 1행을 제외하고 전공이 들어간다. 
	- 내부의 매트릭스는 열에서 행으로 이동한 인원을 나타낸다. 
- 아래 그림처럼 대학 전공에서 각 직업으로 이동하는 방식으로 표현해주면 된다. 

![](https://github.com/anarinsk/gwcho-circlize/blob/main/images/gwcho_6.png?raw=true){: style="textalign:center; " width="500"}  

- 엑셀로 직업할 경우 반드시 "csv utf-8(쉼표로분리)(*.csv)로 저장해야 한다. 다른 csv 포맷으로 저장할 경우 에러의 원인이 된다. 
- 파일을 넣고 코드 다이어그램을 생성할 때 `file_name`을 이 녀석으로 맞춰주자. 


### 색깔 데이터 


- 코드 다이어그램을 그리기 위해서는 전공에 관해서 색깔이 지정되어야 한다. 
- csv 파일을 열어 지정해주자. 
- 색깔을 지정하는 csv 파일 이름은 `color_selection.csv` 고정되어 있다. 
  - Binder를 로드할 때마다 올려줘야 한다. 
  - 만일 영구적으로 바꾸고 싶다면 파일을 나에게 전달하라! 
- 전공-직업이동 데이터에서 전공 수 만큼의 색깔 지정이 필요하다. 
- 원색은 되도록 쓰지 않는 편을 권한다. 색 이름은 [https://www.datanovia.com/en/blog/awesome-list-of-657-r-color-names/](https://www.datanovia.com/en/blog/awesome-list-of-657-r-color-names/)를 참고 














<!--stackedit_data:
eyJoaXN0b3J5IjpbNDQzNDI1NTc4LC0yMzI3NTExNzcsMTUxOT
gxNTU1MCwtMTc0ODg1NjA0MywtNTk4ODQwNTI1LDEzNzc2ODQ5
OSwtMTI1NTUyMDQ2XX0=
-->