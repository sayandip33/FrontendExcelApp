-- Update only voice_segment
UPDATE ivruser.message_segments
SET voice_segment = 'IBTS/1543.wav'
WHERE client_id = '1232' AND msg_id = 'ENTER_EXP_DATE';

UPDATE ivruser.message_segments
SET voice_segment = 'IBTS/1542.wav'
WHERE client_id = '1232' AND msg_id = 'EXP_DATE_MSG';

COMMIT;



-- Rollback to previous voice_segment values
UPDATE ivruser.message_segments
SET voice_segment = 'IBTS/1143.wav'
WHERE client_id = '1232' AND msg_id = 'ENTER_EXP_DATE';

UPDATE ivruser.message_segments
SET voice_segment = 'IBTS/1121.wav'
WHERE client_id = '1232' AND msg_id = 'EXP_DATE_MSG';

COMMIT;
