package uz.pdp.uzummarket.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import uz.pdp.uzummarket.enums.NotificationType;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "notifications")
public class Notification {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "from_id", nullable = false)
    private Integer fromId;

    @Column(name = "to_id", nullable = false)
    private Integer toId;

    @Column(name = "question_sent_time", nullable = false)
    private LocalDateTime questionSentTime;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private NotificationType type;

    @Column(nullable = false)
    private String message;

    private String answer;

    @Column(name = "answer_sent_time")
    private LocalDateTime answerSentTime;

    @ManyToOne
    @JoinColumn(name = "as_reply_product")
    private Product asReplyProduct;

    @Column(name = "is_read", nullable = false)
    private Boolean isRead;
}