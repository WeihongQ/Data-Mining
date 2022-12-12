keep qn6011 wv101 qm509 pid fid18 provcd18 urban18 gender age cfps2018edu qp101 qp102 income qa9 qea0 qga1 qn8011 qn4001 qka202 qka203 qu1m qu201 qu202 qu801 qu802 qu803 qu804 qu805 qu806 qm2011 qm2016 qm6 qn1001 qn10021 qn10022 qn10023 qn10024 qn10025 qn10026 qn12012 qn12016 qn8012 qm6010 qm6011 qm6012 qm6013 qm6014 qm6015 qm6016 qm6017 qn201_b_1 qn202 qn203 qn4002 qn4004 qn4005 qn4003 qph1 qp103 qp201 qq201 qq301 qq401 qq501 qq1001 qq1002 qq1101 qn406 qn407 qn4011 qn4014 qn4012 qn4016 qn4018 qn40120 wordtest18 mathtest18

//dependent variable / class variable
rename qn6011 ideology_political
rename wv101 ideology_economic
rename qm509 ideology_social

// demographic var
//gender age urban province
rename cfps2018edu edu
rename qa9 veteran
rename qea0 marriage
rename qga1 fulljob
rename qn4001 party_member
rename qn4002 league_member
rename qn4004 religion_member
rename qn4003 union_member
rename qn4005 individual_worker_union


//life habits
rename qq1001 time_tv_movie
rename qq1002 family_dinner
rename qq1101 reading
rename qq201 smoke
rename qq301 drink
rename qq401 nap

// physical health
rename qp101 height
rename qp102 weight
rename qp103 hand
rename qp201 health


//mental health
rename qn406 depression
rename qn407 difficult_life
rename qn4011 bad_sleep
rename qn4012 happy
rename qn4014 lonely
rename qn4016 life_happy
rename qn4018 sad
rename qn40120 pessimistic
rename qq501 memory


//religious belief
rename qm6010 buddha
rename qm6011 god
rename qm6012 Allah
rename qm6013 christ
rename qm6014 jesus
rename qm6015 ancestors
rename qm6016 ghost
rename qm6017 fengshui

//information consuming habits
rename qu1m mobile_phone
rename qu201 mobile_net
rename qu202 computer
rename qu801 channel_tv
rename qu802 channel_internet
rename qu803 channel_paper
rename qu804 channel_broadcast
rename qu805 channel_message
rename qu806 channel_person
rename qn201_b_1 info_tv
rename qn202 info_internet
rename qn203 internet_comment

//subjective evaluation
rename qm2011 inter_relation
rename qm2016 happiness
rename qph1 donation

rename qka202 exp_child
rename qka203 exp_son
rename qm6 altruistic
rename qn1001 trust
rename qn10021 trust_parents
rename qn10022 trust_neighbor
rename qn10023 trust_american
rename qn10024 trust_stangers
rename qn10025 trust_cadre
rename qn10026 trust_doctor
rename qn12012 satisfaction
rename qn12016 confidence

rename qn8012 local_status
rename qn8011 local_income

//data clean and normalization
replace ideology_economic=. if ideology_economic<0
replace ideology_social=. if ideology_social<0
replace ideology_political=. if ideology_political<0


replace urban18 =. if urban18==-9
replace age =. if age<18
replace veteran=. if veteran==-8 | veteran==-1
replace marriage=. if marriage==-8
replace fulljob=. if fulljob==-8
replace income=. if income<0 //large missing
replace exp_child=. if exp_child<0
replace exp_son=. if exp_son<0 //large missing
replace mobile_net=. if mobile_net<0
replace channel_tv=. if channel_tv<0
replace channel_internet=. if channel_internet<0
replace channel_paper=. if channel_paper<0
replace channel_broadcast=. if channel_broadcast<0
replace channel_message=. if channel_message<0
replace channel_person=. if channel_person<0
replace inter_relation=. if inter_relation<0
replace happiness=. if happiness<0
replace altruistic=. if altruistic<0
replace trust=. if trust<0
replace trust_parents=. if trust_parents<0
replace trust_neighbor=. if trust_neighbor<0
replace trust_american=. if trust_american<0
replace trust_stangers=. if trust_stangers<0
replace trust_cadre=. if trust_cadre<0
replace trust_doctor=. if trust_doctor<0
replace satisfaction=. if satisfaction<0
replace confidence=. if confidence<0
replace local_income=. if local_income<0
replace local_status=. if local_status<0
replace buddha=. if buddha<0
replace god=. if god<0
replace Allah=. if Allah<0
replace christ=. if christ<0
replace jesus=. if jesus<0
replace ancestors=. if ancestors<0
replace ghost=. if ghost<0
replace fengshui=. if fengshui<0
replace info_tv=. if info_tv<0
replace info_internet=. if info_internet<0
replace internet_comment=. if internet_comment<0
replace party_member=. if party_member<0
replace league_member=. if league_member<0
replace religion_member=. if religion_member<0
replace union_member=. if union_member<0
replace individual_worker_union=. if individual_worker_union<0
replace donation=. if donation<0
replace height=. if height<0
replace weight=. if weight<0
replace hand=. if hand<0
replace health=. if health<0
replace smoke=. if smoke<0
replace drink=. if drink<0
replace nap=. if nap<0
replace memory=. if memory<0
replace time_tv_movie=. if time_tv_movie<0
replace family_dinner=. if family_dinner<0
replace depression=. if depression<0
replace difficult_life=. if difficult_life<0
replace bad_sleep=. if bad_sleep<0
replace happy=. if happy<0
replace lonely=. if lonely<0
replace life_happy=. if life_happy<0
replace sad=. if sad<0
replace pessimistic=. if pessimistic<0
replace mathtest18=. if mathtest18<0


//info_internet and internet_comment create much attrition even though fill the missings with family average
//mathtest has many missings

bys fid: egen avgincome = mean(income)
replace income = avgincome if income==.
drop avgincome

bys fid: egen avgson = mean(exp_son)
replace exp_son=avgson if exp_son==.
drop avgson

bys fid: egen avg = mean(info_internet)
replace info_internet=avg if info_internet==.
drop avg

bys fid: egen avg = mean(internet_comment)
replace internet_comment=avg if internet_comment==.
drop avg



