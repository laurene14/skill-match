import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="swipe"
export default class extends Controller {
  static targets = ["card", "confetti"]

  currentUserId = null;
  csrfToken = null;

  connect() {
    console.log("connected");
    this.currentUserId = parseInt(document.body.dataset.currentUserId, 10);
    this.csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    this.initConfetti();
    this.initCards(true);
    this.cardTargets.forEach((card) => {
      this.initCard(card);
    });
  }

  initConfetti() {
    let confetti = new Confetti('confetti');
    confetti.setCount(75);
    confetti.setSize(2);
    confetti.setPower(50);
    confetti.setFade(false);
    confetti.destroyTarget(false);
  }

  initCards(first_init) {
    const activeCards = this.cardTargets.filter(card => !card.classList.contains("removed"));
    activeCards.forEach((card, index) => {
      card.style.zIndex = activeCards.length - index;
      // line below can generate the card pile in another way
      // card.style.transform = 'scale(' + (20 - index) / 20 + ') translateY(-' + 24 * index + 'px)';
      card.style.opacity = (10 - index) / 10;
      if (first_init && index !== 0) {
        const randomRotation = (Math.random() * 18) - 9;
        card.style.transform = ` rotate(${randomRotation}deg)`;
      } else if (!first_init && index == 0) {
        card.style.transform = 'rotate(0deg)'
      }
    });
    this.element.classList.add('loaded');
  }


  initCard(card) {
    const hammertime = new Hammer(card);

    hammertime.on('pan', (event) => {
      if (event.pointers.length > 1) {
        return;
      }
      event.preventDefault();
      card.classList.add('moving');

      if (event.deltaX === 0) return;
      if (event.center.x === 0 && event.center.y === 0) return;

      this.handleToggleStatusClass(event);

      var xMulti = event.deltaX * 0.03;
      var yMulti = event.deltaY / 80;
      var rotate = xMulti * yMulti;

      card.style.transform = 'translate(' + event.deltaX + 'px, ' + event.deltaY + 'px) rotate(' + rotate + 'deg)';
    });

    hammertime.on('panend', (event) => {
      card.classList.remove('moving');

      var moveOutWidth = document.body.clientWidth;
      var keep = Math.abs(event.deltaX) < 80 || Math.abs(event.velocityX) < 0.5;
      card.classList.toggle('removed', !keep);

      this.handleRemoveStatusClass(card, !keep);
      if (keep) {
        card.style.transform = '';
      } else {
        var endX = Math.max(Math.abs(event.velocityX) * moveOutWidth, moveOutWidth);
        var toX = event.deltaX > 0 ? endX : -endX;
        var endY = Math.abs(event.velocityY) * moveOutWidth;
        var toY = event.deltaY > 0 ? endY : -endY;
        var xMulti = event.deltaX * 0.03;
        var yMulti = event.deltaY / 80;
        var rotate = xMulti * yMulti;

        card.style.transform = 'translate(' + toX + 'px, ' + (toY + event.deltaY) + 'px) rotate(' + rotate + 'deg)';
        this.initCards(false);
      }
    })
  };

  handleToggleStatusClass(event) {
    this.element.classList.toggle('swipe--accept', event.deltaX > 0);
    this.element.classList.toggle('swipe--refuse', event.deltaX < 0);
  }

  handleRemoveStatusClass(card, leave) {
    if (this.element.classList.contains('swipe--accept')) {
      this.element.classList.remove('swipe--accept');
      if (leave) {
        this.handleAccept(card);
      }
    } else {
      this.element.classList.remove('swipe--refuse');
      if (leave) {
        this.handleRefuse(card);
      }
    }
  }

  clickAccept(event) {
    this.handleClickStatusButton(event, 1);
    event.preventDefault();
  }
  clickRefuse(event) {
    this.handleClickStatusButton(event, 2)
    event.preventDefault();
  }

  clickFollow(event) {
    this.handleClickStatusButton(event, 3)
    event.preventDefault();
  }

  handleClickStatusButton(event, status) {
    const activeCards = this.cardTargets.filter(card => !card.classList.contains("removed"));
    const moveOutWidth = document.body.clientWidth * 1.5
    if (!activeCards.length) return false;
    var card = activeCards[0];
    card.classList.add('removed');
    if (status === 1) {
      card.style.transform = 'translate(' + moveOutWidth + 'px, -100px) rotate(-30deg)';
      this.handleAccept(activeCards[0]);
    } else if (status === 2) {
      card.style.transform = 'translate(-' + moveOutWidth + 'px, -100px) rotate(30deg)';
      this.handleRefuse(activeCards[0]);
    } else if (status === 3) {
      var moveOutHeight = document.body.clientHeight;
      card.style.transform = 'translateY(-' + moveOutHeight + 'px)';
      this.handleFollow(activeCards[0]);
    }
    this.initCards(false);
  }

  handleRefuse(card) {
    if (card.id === "filtered" && card.id === "all") {
      // waiting for list
      window.location.href = '#'
    } else {
      const url = '/likes'
      const body = JSON.stringify({
        "liker_id": this.currentUserId,
        "liked_id": card.id,
        "wanted": false
      })
      this.fetchData(url, body)
    }
  }

  handleAccept(card) {
    if (card.id === "filtered") {
      window.location.href = '/likes?all='
    } else if (card.id === "all") {
      // waiting for list
      window.location.href = '#'
    } else {
      const url = '/likes'
      const body = JSON.stringify({
        "liker_id": this.currentUserId,
        "liked_id": parseInt(card.id, 10),
        "wanted": true
      })
      this.fetchData(url, body)
    }
  }

  handleFollow(card) {
    const url = '/bookmarks'
    const body = JSON.stringify({
      "follower_id": this.currentUserId,
      "following_id": parseInt(card.id, 10),
    });
    this.fetchData(url, body)

  }

  fetchData(url, body) {
    const options = {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        'X-CSRF-Token': this.csrfToken
      },
      body
    }
    fetch(url, options)
      .then(response => {
        if (!response.ok) {
          return response.json().then(errorData => {
            throw new Error(JSON.stringify(errorData));
          });
        }
        return response;
      })
      .then(response => {if (response.status == 207) {
        this.clickInTheMiddle();
      }})
      .catch(error => console.log(error))
  }

  clickInTheMiddle() {
    console.log("confetti")
    this.confettiTarget.style.display="block";
    const rect = this.confettiTarget.getBoundingClientRect();
    const middleX = rect.left + (rect.width / 2);
    const middleY = rect.top + (rect.height / 2);
    const event = new MouseEvent('click', {
      clientX: middleX,
      clientY: middleY,
      bubbles: true,
      cancelable: true,
      view: window
    });
    this.confettiTarget.dispatchEvent(event);
    this.confettiTarget.style.display="none";
  }
}
