
<if cond="selectedYear == year1">
      <foreach item="element" array="year1Array">
        <audio expr="standardAudioUrl + element + '.wav'"/>
      </foreach>
    <elseif cond="selectedYear == year2"/>
      <foreach item="element" array="year2Array">
        <audio expr="standardAudioUrl + element + '.wav'"/>
      </foreach>
    </if>
